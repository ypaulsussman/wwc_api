# frozen_string_literal: true

class AddSearchableFieldsToStudies < ActiveRecord::Migration[6.0]
  def up
    # TODO: Why do we need to double-escape regex?
    # TODO: Why do citations ending in '). ' wipe their entire contents in L22
    # the (first regexp_replace), even when the 'g' flag isn't specified && there's a prior match?
    execute <<-SQL
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
              regexp_replace(
                regexp_replace(citation, '.*\\)\\.\\s', ''),
                '\\..*',
                ''
              ),
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
