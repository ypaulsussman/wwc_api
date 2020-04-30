# frozen_string_literal: true

class CreateClassTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :class_types do |t|
      t.text :name

      t.timestamps
    end
  end
end
