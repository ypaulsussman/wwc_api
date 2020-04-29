# What Works Clearinghouse API

## Setup
- **Option 01:** run `rails db:prepare studies=db/WWC-export-archive-2020-Apr-25-142355/Studies.csv findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv reports=db/WWC-export-archive-2020-Apr-25-142355/InterventionReports.csv`
  - For newer data, simply substitute the CSV filepaths: modulo any newly-added corruptions to the data, the scrubbers/loaders should function identically.
  - This option is _sloooooooooow_ -- like, ~8-9 minutes slow. It's doing tons of table sequential-scans, and instancing tons of ActiveRecord objects (_neither of which is necessary: but the removal of which is an optimization I haven't yet had time for._)
- **Option 02:** run `rails db:create && psql -d wwc_api_development -f db/2020_04_25_snapshot.sql`
  - You're stuck with the data from April 25th, 2020 (_unless you want to update and PR!_) 😸
  - On the other hand, this method takes... ~2 seconds?

## Initial Data Corruptions (Contact WWC Later)
- Malformed CSV's (_see scrubbers for steps to fix_)
- In `reviewdictionary`: `reviewid` field is missing from `studies` and `findings`
- In `studies`: `demographics_of_study_sample_international` is `boolean`, not `percent`
- In `studies`: `ethnicity_hispanic` and `ethnicity_not_hispanic` are `percent`, not `boolean`
- In `studies`: `productid` doesn't map to unique `product_name` for ID's ( 1, 11, 12, 14, 15, 18, 19, 21, 22, 23)
- In `studies`: `study_design` undercounts `Randomized c/Controlled t/Trial` by case-sensitive split in records
- In `intervention_reports`: `outcome_domain` is `text`, not `int`

## Progress Log (Steps to v1)
- Initial Commit:
  - `rails new wwc_api --api --skip-sprockets --skip-action-mailbox --skip-action-text --skip-sprockets --skip-system-test --skip-turbolinks --database=postgresql`
  - Clean up `Gemfile` and `application.rb`
  - Add `Rack::Cors` and `Rack::Attack` middlewares to `initializers/`
- Second Commit:
  - Pull `JsonWebToken`, `User`, `ApplicationController`, `TokensController`, and `Rails.application.routes.draw` code from initial JWT-playground repo
  - Disable JWT-authentication, for now: assume no one cares about this repo enough to actively abuse the API, and that `Rack::Attack` will cover most passive cases
- Third Commit: ...README Typos 😇
- Fourth Commit:
  - `rails g model Intervention name:text`
  - `rails g model OutcomeMeasure name:text`
  - `rails g model Finding intervention:references outcome_measure:references comparison:text outcome_domain:text period:text sample_description:text is_subgroup:boolean outcome_sample_size:integer outcome_measure_intervention_sample_size:float outcome_measure_comparison_sample_size:float intervention_clusters_sample_size:integer comparison_clusters_sample_size:integer intervention_mean:float comparison_mean:float intervention_standard_deviation:integer comparison_standard_deviation:integer effect_size_study:float effect_size_wwc:float improvement_index:float p_value_study:float p_value_wwc:float icc:float clusters_total:float is_statistically_significant:boolean finding_rating:text essa_rating:text l1_unit_of_analysis:text`
  - Add most-current copy of WWC data to `db` (_the code makes this replaceable ad lib; when seeding, simply specify path to different data-dir_)
  - Add `findings` scrubber and importer to `seeds.rb`
- Fifth Commit: 
  - Add `studies` scrubber and importer to `seeds.rb`
- Sixth Commit:
  - `rails g model Product name:text wwcid:integer`
    - Note: you ran `rails d model` and the `rails g model` with the second field; that's why this migration follows the others
    - No idea why you didn't create a new migration to add the `wwcid` field, once it became clear its non-uniqueness prevents its from functioning as a PK 
  - `rails g model Protocol name:text version:float`
  - `rails g model Review intervention_id:integer product_id:integer protocol_id:integer standards_version:text purpose_of_review:text posting_date:date study_rating:text rating_reason:text ineligibility_reason:text`
  - Add `has_many ...` and `belongs_to ..., optional: true` to connect `Review` to other models (_it can't use_ `my_model:references` _in its generators b/c some review records lack even one of the three_)
  - `rails g model Study review:references citation:text publication:text publication_date:text study_page_url:text study_design:text ericid:text multisite:boolean demographics_of_study_sample_international:boolean demographics_of_study_sample_english_language_learners:float demographics_of_study_sample_free_or_reduced_price_lunch:float ethnicity_hispanic:float ethnicity_not_hispanic:float race_asian:float race_black:float race_native_american:float race_other:float race_pacific_islander:float race_white:float gender_female:float gender_male:float`
  - `rails g migration AddReviewRefToFindings review:references`
  - `rails db:reset studies=db/WWC-export-archive-2020-Apr-25-142355/Studies.csv`
  - `rails db:seed findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv`
  - Add formatted temp-file handling to `seeds.rb`/`*_scrubber.rb`
- Seventh Commit:
  - `rails g migration AddWwcidToInterventions wwcid:integer`
  - `rails g migration DropReviewRefFromStudies review:references`
  - `rails g migration AddStudyReftoReviews study:references`
  - Invert (_that is, correct_) the `has_many`/`belongs_to` on `Study` and `Review`
  - Add `has_many :findings, through: :reviews` to `Study`
  - Replace the above migrations with manual updates to the prior migrations... mostly just to see if it breaks anything (_so far, so good?_)
- Eighth Commit:
  - Extract `studies`/`findings` seed-code into separate `*_loader.rb` files
- Ninth Commit:
  - `rails g migration AddWwcUrlToInterventions`
  - `rails g model InterventionReport intervention_id:integer protocol_id:integer numstudiesmeetingstandards:integer numstudieseligible:integer sample_size_intervention:integer effectiveness_rating:text outcome_domain:text`
  - Correct the `has_many`/`belongs_to` associations on a couple models
- Tenth Commit:
  - Create `add_sites_to_studies.rb` seed-code
  - `rails g model Site name:text region:boolean`
  - `rails g migration CreateJoinTableStudySite study site`

## Next Steps: Server
- For `studies` table, create Ruby script to replace states (_et al_) fields w/ many-many join table (_...eventually_)
- Extract `outcome_domain` to separate Model (_...eventually_)
- Add scraper script for FTS `descriptions` field on `interventions` table
  - Use `Intervention_Page_URL`?
  - Use `pg_search` this time; reference these posts:
    - https://pganalyze.com/blog/full-text-search-ruby-rails-postgres
    - https://thoughtbot.com/blog/optimizing-full-text-search-with-postgres-tsvector-columns-and-triggers
    - https://www.viget.com/articles/implementing-full-text-search-in-rails-with-postgres/

## Next Steps: Client
- Build `Controller` classes only as needed
- No CSS framework: use FEM notes/O'Reilly books (can possibly reuse across apps)
- One API, two SPA's
  - Vue app
    - New framework
    - Still have component classes/lifecycle events
  - React app
    - Familiar framework
    - Only use Hooks and Context API's for state-management
