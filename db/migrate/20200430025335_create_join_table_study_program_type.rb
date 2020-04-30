class CreateJoinTableStudyProgramType < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :program_types do |t|
      # t.index [:study_id, :program_type_id]
      # t.index [:program_type_id, :study_id]
    end
  end
end
