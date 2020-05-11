# frozen_string_literal: true

class AddSearchableFieldsToStudies < ActiveRecord::Migration[6.0]
  def up
    # TODO: Why do we need to double-escape regex?
    execute <<-SQL
      -- see https://www.2ndquadrant.com/en/blog/generated-columns-in-postgresql-12/
      -- "PostgreSQL text functions are considered volatile when they are locale specific... (and)
      -- nearly every text function is locale dependent": so redefine regexp_match as immutable
      CREATE OR REPLACE FUNCTION extracted_title(text, text)
      RETURNS TEXT[] AS 'regexp_match' LANGUAGE internal immutable;

      ALTER TABLE studies
      ADD
        COLUMN author_fts tsvector GENERATED ALWAYS AS (
          to_tsvector(
            'english',
            coalesce(regexp_replace(citation, '\\(.*', '', 'g'), '')
          )
        ) STORED,
      ADD
        COLUMN title_fts tsvector GENERATED ALWAYS AS (
          to_tsvector(
            'english',
            coalesce(
                (extracted_title(citation, '\\)\\. ([^\\.]+)'))[1],
              ''
            )
          )
        ) STORED,
      ADD
        COLUMN publication_fts tsvector GENERATED ALWAYS AS (
          to_tsvector(
            'english',
            coalesce(
              regexp_replace(publication, '[\\d]+', ''),
              ''
            )
          )
        ) STORED,
      ADD
        COLUMN publication_year integer GENERATED ALWAYS AS (
          CASE
            WHEN regexp_replace(publication_date, '[^\\d]+', '', 'g') != ''
            THEN regexp_replace(publication_date, '[^\\d]+', '', 'g')
            ELSE null
          END :: integer
        ) STORED;
    SQL
  end

  def down
    remove_column :studies, :author_fts
    remove_column :studies, :title_fts
    remove_column :studies, :publication_fts
    remove_column :studies, :publication_year
  end
end
