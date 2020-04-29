# frozen_string_literal: true

class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.text :name
      t.boolean :region

      t.timestamps
    end
  end
end
