# frozen_string_literal: true

class CreateJoinTableStudyTopic < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :topics do |t|
      # t.index [:study_id, :topic_id]
      # t.index [:topic_id, :study_id]
    end
  end
end
