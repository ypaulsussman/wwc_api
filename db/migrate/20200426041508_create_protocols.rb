# frozen_string_literal: true

class CreateProtocols < ActiveRecord::Migration[6.0]
  def change
    create_table :protocols do |t|
      t.text :name
      t.float :version

      t.timestamps
    end
  end
end
