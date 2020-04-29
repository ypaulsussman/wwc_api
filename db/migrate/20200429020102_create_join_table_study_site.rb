# frozen_string_literal: true

class CreateJoinTableStudySite < ActiveRecord::Migration[6.0]
  def change
    create_join_table :studies, :sites do |t|
      t.index [:study_id, :site_id]
      t.index [:site_id, :study_id]
    end
  end
end
