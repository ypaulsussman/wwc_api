# What Works Clearinghouse API

- Initial Commit:
  - `rails new wwc_api --api --skip-sprockets --skip-action-mailbox --skip-action-text --skip-sprockets --skip-system-test --skip-turbolinks --database=postgresql`
  - Clean up `Gemfile` and `application.rb`
  - Add `Rack::Cors` and `Rack::Attack` middlewares to `initializers/`
- Second Commit:
  - Pull `JsonWebToken`, `User`, `ApplicationController`, `TokensController`, and `Rails.application.routes.draw` code from initial JWT-playground repo
  - Disable JWT-authentication, for now: assume no one cares about this repo enough to actively abuse the API, and that `Rack::Attack` will cover most passive cases
- Third Commit:
  - `rails g model Intervention name:text`
  - `rails g model OutcomeMeasure name:text`
  - `rails g model Finding intervention:references outcome_measure:references comparison:text outcome_domain:text period:text sample_description:text is_subgroup:boolean outcome_sample_size:integer outcome_measure_intervention_sample_size:float outcome_measure_comparison_sample_size:float intervention_clusters_sample_size:integer comparison_clusters_sample_size:integer intervention_mean:float comparison_mean:float intervention_standard_deviation:integer comparison_standard_deviation:integer effect_size_study:float effect_size_wwc:float improvement_index:float p_value_study:float p_value_wwc:float icc:float clusters_total:float is_statistically_significant:boolean finding_rating:text essa_rating:text l1_unit_of_analysis:text`
  - Add most-current copy of WWC data to `db` (_the code makes this replaceable ad lib; when seeding, simply specify path to different data-dir_)
  - Add `findings` scrubber and importer to `seeds.rb`
