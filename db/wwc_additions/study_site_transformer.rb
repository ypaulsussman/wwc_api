# frozen_string_literal: true

require 'csv'
require 'pg'

def @studies_data.add_sites(path_to_csv, db_name)
  # Step 01. Create hash of each field that begins with `Region_State_*`
  headers = nil
  # Based on prior evidence, we can't trust that the ReviewDictionary.csv isn't missing headers;
  # in addition, each .csv is malformed on at least one row. Grab the headers and get out.
  CSV.foreach(path_to_csv, headers: true, return_headers: true) do |row|
    headers = row.headers
    break
  end

  id_for_db = 0
  regions_hash = headers.each_with_object({}) do |header, memo|
    next unless header.include?('Region_State_')

    id_for_db += 1
    memo[header] = [id_for_db, header[13..-1].gsub(/_/, ' ')]
  end

  # Step 02. Populate `sites` table
  conn = PG.connect(dbname: db_name)

  list_of_regions = ['Midwest', 'Northeast', 'South', 'West']
  populate_query = 'INSERT INTO sites(id, name, region, created_at, updated_at) VALUES '

  # key is CSV fieldname, v0 is int ID, v1 is parsed state-name
  regions_hash.each do |_, v|
    populate_query +=
      "(#{v[0]}, #{conn.escape_literal(v[1])}, #{list_of_regions.include? v[1]}, NOW(), NOW()), "
  end

  populate_query.chomp!(', ') << ';'
  conn.exec(populate_query)

  # Step 03. Reread `studies.csv`, adding to join table whenever a study occurred at a site
  CSV.foreach(path_to_csv, headers: true) do |row|
    regions_hash.each do |k, v|
      next unless row[k] == '1.00'

      conn.exec('INSERT INTO sites_studies(study_id, site_id) VALUES '\
        "(#{conn.escape_literal(row['StudyID'])}, #{v[0]})")
    end
  end

  remove_dupes = <<~SQL
    DELETE FROM sites_studies ss1 USING sites_studies ss2
    WHERE
      ss1.ctid < ss2.ctid
      AND ss1.study_id = ss2.study_id
      AND ss1.site_id = ss2.site_id
  SQL

  conn.exec(remove_dupes)
end
