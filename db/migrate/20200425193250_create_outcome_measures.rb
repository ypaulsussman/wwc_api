# frozen_string_literal: true

class CreateOutcomeMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :outcome_measures do |t|
      t.text :name

      t.timestamps
    end
  end
end
