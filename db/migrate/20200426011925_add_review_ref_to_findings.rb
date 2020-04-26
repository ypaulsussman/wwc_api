# frozen_string_literal: true

class AddReviewRefToFindings < ActiveRecord::Migration[6.0]
  def change
    add_reference :findings, :review, null: false, foreign_key: true
  end
end
