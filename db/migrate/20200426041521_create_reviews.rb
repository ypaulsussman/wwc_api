# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :intervention_id
      t.integer :product_id
      t.integer :protocol_id
      t.integer :study_id
      t.text :standards_version
      t.text :purpose_of_review
      t.date :posting_date
      t.text :study_rating
      t.text :rating_reason
      t.text :ineligibility_reason

      t.timestamps
    end
  end
end
