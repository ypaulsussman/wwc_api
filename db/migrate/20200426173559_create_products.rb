# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :name
      t.integer :wwcid

      t.timestamps
    end
  end
end
