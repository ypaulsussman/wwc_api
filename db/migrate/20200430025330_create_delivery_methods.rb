# frozen_string_literal: true

class CreateDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_methods do |t|
      t.text :name

      t.timestamps
    end
  end
end
