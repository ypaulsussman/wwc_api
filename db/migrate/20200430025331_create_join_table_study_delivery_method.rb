# frozen_string_literal: true

class CreateJoinTableStudyDeliveryMethod < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :delivery_methods do |t|
      # t.index [:study_id, :delivery_method_id]
      # t.index [:delivery_method_id, :study_id]
    end
  end
end
