# frozen_string_literal: true

class CreateJoinTableStudyClassType < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :class_types do |t|
      # t.index [:study_id, :class_type_id]
      # t.index [:class_type_id, :study_id]
    end
  end
end
