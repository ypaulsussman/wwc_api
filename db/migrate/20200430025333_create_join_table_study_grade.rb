class CreateJoinTableStudyGrade < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :grades do |t|
      # t.index [:study_id, :grade_id]
      # t.index [:grade_id, :study_id]
    end
  end
end
