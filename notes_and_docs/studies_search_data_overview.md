# STUDIES OVERVIEW

studies                     | 12175
  - citation                                                 | text; 12175 not-null
  - publication                                              | text; 11951 not-null
    - 1433 contain 'dissertation'; 
    - most appear to be final subset of `citation` field
  - publication_date                                         | text; 12175 not-null
  - study_page_url                                           | text; 12175 not-null
  - ericid                                                   | text; 1980 not-null

  - study_design
    - {null}                          |  9962
    - Randomized Controlled Trial     |   824
    - Quasi-Experimental Design       |   773
    - Pretest-posttest                |   274
    - Other design                    |   154
    - Single Case Design              |    98
    - Meta-analysis                   |    85
    - Regression Discontinuity Design |     5

  - multisite                                                | boolean; 289 true
  - demographics_of_study_sample_international               | boolean; 13 true
  - demographics_of_study_sample_english_language_learners   | percent; 267 not-null
  - demographics_of_study_sample_free_or_reduced_price_lunch | percent; 338 not-null

  - ethnicity_hispanic                                       | percent; 475 not-null
  - ethnicity_not_hispanic                                   | percent; 452 not-null

  - race_asian                                               | percent; 210 not-null
  - race_black                                               | percent; 490 not-null
  - race_native_american                                     | percent; 61 not-null
  - race_pacific_islander                                    | percent; 19 not-null
  - race_white                                               | percent; 460 not-null
  - race_other                                               | percent; 277 not-null

  - gender_female                                            | percent; 591 not-null
  - gender_male                                              | percent; 593 not-null


## STUDIES QUALIFIERS
                            | Vals, Records, distinct studies
topics                      | 12, 24659, 11615
grades                      | 15, 2194, 805
delivery_methods            | 4, 853, 766
sites                       | 55, 1790, 680
urbanicities                | 3, 850, 641
program_types               | 6, 728, 627
school_types                | 4, 484, 468
class_types                 | 2, 200, 193



## STUDIES SIBLINGS
reviews                     | 15254
findings                    | table
intervention_reports        | table

interventions               | table
outcome_measures            | table
products                    | table
protocols                   | table



## JOIN TABLES
class_types_studies         | table
delivery_methods_studies    | table
grades_studies              | table
program_types_studies       | table
school_types_studies        | table
sites_studies               | table
studies_topics              | table
studies_urbanicities        | table
