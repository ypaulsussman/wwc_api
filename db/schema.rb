# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Style/NumericLiterals, Style/StringLiterals
ActiveRecord::Schema.define(version: 2020_04_25_193416) do
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
    t.index ["intervention_id"], name: "index_findings_on_intervention_id"
    t.index ["outcome_measure_id"], name: "index_findings_on_outcome_measure_id"
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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "findings", "interventions"
  add_foreign_key "findings", "outcome_measures"
end
# rubocop:enable Metrics/BlockLength, Style/NumericLiterals, Style/StringLiterals
