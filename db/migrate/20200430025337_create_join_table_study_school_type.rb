# frozen_string_literal: true

class CreateJoinTableStudySchoolType < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :school_types do |t|
      # t.index [:study_id, :school_type_id]
      # t.index [:school_type_id, :study_id]
    end
  end
end
