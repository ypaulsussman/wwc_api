# frozen_string_literal: true

class CreateStudies < ActiveRecord::Migration[6.0]
  def change
    create_table :studies do |t|
      t.text :citation
      t.text :publication
      t.text :publication_date
      t.text :study_page_url
      t.text :study_design
      t.text :ericid
      t.boolean :multisite
      t.boolean :demographics_of_study_sample_international
      t.float :demographics_of_study_sample_english_language_learners
      t.float :demographics_of_study_sample_free_or_reduced_price_lunch
      t.float :ethnicity_hispanic
      t.float :ethnicity_not_hispanic
      t.float :race_asian
      t.float :race_black
      t.float :race_native_american
      t.float :race_other
      t.float :race_pacific_islander
      t.float :race_white
      t.float :gender_female
      t.float :gender_male

      t.timestamps
    end
  end
end
