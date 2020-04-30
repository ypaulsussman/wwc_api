# frozen_string_literal: true

class CreateJoinTableStudyUrbanicity < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :urbanicities do |t|
      # t.index [:study_id, :urbanicity_id]
      # t.index [:urbanicity_id, :study_id]
    end
  end
end
