# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Style/NumericLiterals, Style/StringLiterals
ActiveRecord::Schema.define(version: 2020_04_26_173559) do
  enable_extension "plpgsql"

  create_table "findings", force: :cascade do |t|
    t.bigint "intervention_id", null: false
    t.bigint "outcome_measure_id", null: false
    t.text "comparison"
    t.text "outcome_domain"
    t.text "period"
    t.text "sample_description"
    t.boolean "is_subgroup"
    t.integer "outcome_sample_size"
    t.float "outcome_measure_intervention_sample_size"
    t.float "outcome_measure_comparison_sample_size"
    t.integer "intervention_clusters_sample_size"
    t.integer "comparison_clusters_sample_size"
    t.float "intervention_mean"
    t.float "comparison_mean"
    t.integer "intervention_standard_deviation"
    t.integer "comparison_standard_deviation"
    t.float "effect_size_study"
    t.float "effect_size_wwc"
    t.float "improvement_index"
    t.float "p_value_study"
    t.float "p_value_wwc"
    t.float "icc"
    t.float "clusters_total"
    t.boolean "is_statistically_significant"
    t.text "finding_rating"
    t.text "essa_rating"
    t.text "l1_unit_of_analysis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "review_id", null: false
    t.index ["intervention_id"], name: "index_findings_on_intervention_id"
    t.index ["outcome_measure_id"], name: "index_findings_on_outcome_measure_id"
    t.index ["review_id"], name: "index_findings_on_review_id"
  end

  create_table "interventions", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "outcome_measures", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.integer "wwcid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "protocols", force: :cascade do |t|
    t.text "name"
    t.float "version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "intervention_id"
    t.integer "product_id"
    t.integer "protocol_id"
    t.text "standards_version"
    t.text "purpose_of_review"
    t.date "posting_date"
    t.text "study_rating"
    t.text "rating_reason"
    t.text "ineligibility_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "studies", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.text "citation"
    t.text "publication"
    t.text "publication_date"
    t.text "study_page_url"
    t.text "study_design"
    t.text "ericid"
    t.boolean "multisite"
    t.boolean "demographics_of_study_sample_international"
    t.float "demographics_of_study_sample_english_language_learners"
    t.float "demographics_of_study_sample_free_or_reduced_price_lunch"
    t.float "ethnicity_hispanic"
    t.float "ethnicity_not_hispanic"
    t.float "race_asian"
    t.float "race_black"
    t.float "race_native_american"
    t.float "race_other"
    t.float "race_pacific_islander"
    t.float "race_white"
    t.float "gender_female"
    t.float "gender_male"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_studies_on_review_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "findings", "interventions"
  add_foreign_key "findings", "outcome_measures"
  add_foreign_key "findings", "reviews"
  add_foreign_key "studies", "reviews"
end
# rubocop:enable Metrics/BlockLength, Style/NumericLiterals, Style/StringLiterals
