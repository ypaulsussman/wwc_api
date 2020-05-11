# frozen_string_literal: true

class AddStudyIdIndexToStudiesTopics < ActiveRecord::Migration[6.0]
  def change
    add_index :studies_topics, [:topic_id, :study_id]
  end
end
