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
- Eleventh, Twelfth, Thirteenth Commit:
  - Generate script, then run, `bundle exec ruby lib/oneoffs/bool_sets_model_generator.rb`
  - `rails db:migrate`
  - Create `bool_sets_transformer.rb` seed-code
