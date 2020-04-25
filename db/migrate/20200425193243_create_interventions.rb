# frozen_string_literal: true

class CreateInterventions < ActiveRecord::Migration[6.0]
  def change
    create_table :interventions do |t|
      t.text :name

      t.timestamps
    end
  end
end
