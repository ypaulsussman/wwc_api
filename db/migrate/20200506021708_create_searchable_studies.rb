# frozen_string_literal: true

class CreateSearchableStudies < ActiveRecord::Migration[6.0]
  def change
    create_table :searchable_studies do |t|

      t.timestamps
    end
  end
end
