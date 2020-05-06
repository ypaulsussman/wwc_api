# frozen_string_literal: true

class AddSearchableStudiesMatView < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Metrics/BlockLength
    reversible do |mig|
      mig.up do
        # TODO: research: why do you need to double-escape in SQL heredoc?
        execute <<~SQL
          CREATE MATERIALIZED VIEW searchable_studies AS
            SELECT
              -- search by:
              to_tsvector(regexp_replace(citation, '\\(.*', '', 'g')) AS author,
              to_tsvector(array_to_string(regexp_matches(citation, '\\)\\. ([^\\.]+)', 'g'), '')) AS title,
              to_tsvector(regexp_replace(publication, '[\\d]+', '', 'g')) as publication,
              regexp_replace(publication_date, '[^\\d]+', '', 'g') AS pub_year,
              demographics_of_study_sample_english_language_learners :: integer AS percent_ell,
              demographics_of_study_sample_free_or_reduced_price_lunch :: integer AS percent_frpl,
              ethnicity_hispanic :: integer AS percent_hispanic,
              gender_male :: integer AS percent_male,
              demographics_of_study_sample_international AS international,
              multisite,
              study_design,
              -- display:
              citation,
              study_page_url,
              ericid,
              id
            FROM studies;

          CREATE INDEX searchable_studies_author_idx ON searchable_studies USING GIN (author);
          CREATE INDEX searchable_studies_publication_idx ON searchable_studies USING GIN (publication);
          CREATE INDEX searchable_studies_title_idx ON searchable_studies USING GIN (title);
          CREATE INDEX searchable_studies_pub_year_idx ON searchable_studies (pub_year);
        SQL
      end
      # rubocop:enable Metrics/BlockLength

      mig.down do
        execute <<~SQL
          DROP MATERIALIZED VIEW IF EXISTS searchable_studies;
        SQL
      end
    end
  end
end
