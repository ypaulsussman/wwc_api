# frozen_string_literal: true

class CreateInterventionReports < ActiveRecord::Migration[6.0]
  def change
    create_table :intervention_reports do |t|
      t.integer :intervention_id
      t.integer :protocol_id
      t.integer :numstudiesmeetingstandards
      t.integer :numstudieseligible
      t.integer :sample_size_intervention
      t.text :effectiveness_rating
      t.text :outcome_domain

      t.timestamps
    end
  end
end
