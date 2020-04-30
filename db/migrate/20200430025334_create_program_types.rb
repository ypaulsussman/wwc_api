# frozen_string_literal: true

class CreateProgramTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :program_types do |t|
      t.text :name

      t.timestamps
    end
  end
end
