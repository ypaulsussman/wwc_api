# frozen_string_literal: true

class CreateFindings < ActiveRecord::Migration[6.0]
  def change
    create_table :findings do |t|
      t.references :intervention, null: false, foreign_key: true
      t.references :outcome_measure, null: false, foreign_key: true
      t.text :comparison
      t.text :outcome_domain
      t.text :period
      t.text :sample_description
      t.boolean :is_subgroup
      t.integer :outcome_sample_size
      t.float :outcome_measure_intervention_sample_size
      t.float :outcome_measure_comparison_sample_size
      t.integer :intervention_clusters_sample_size
      t.integer :comparison_clusters_sample_size
      t.float :intervention_mean
      t.float :comparison_mean
      t.integer :intervention_standard_deviation
      t.integer :comparison_standard_deviation
      t.float :effect_size_study
      t.float :effect_size_wwc
      t.float :improvement_index
      t.float :p_value_study
      t.float :p_value_wwc
      t.float :icc
      t.float :clusters_total
      t.boolean :is_statistically_significant
      t.text :finding_rating
      t.text :essa_rating
      t.text :l1_unit_of_analysis

      t.timestamps
    end
  end
end
