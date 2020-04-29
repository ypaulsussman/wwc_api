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

  i = 0
  initial_regions_kv = headers.each_with_object({}) do |h, memo|
    next unless h.include?('Region_State_')

    i += 1
    memo[h] = [i, h[13..-1].gsub(/_/, ' ')]
  end

  # Step 02. Populate `sites` table
  conn = PG.connect(dbname: db_name)

  list_of_regions = ['Midwest', 'Northeast', 'South', 'West']
  populate_query = 'INSERT INTO sites(id, name, region, created_at, updated_at) VALUES '

  initial_regions_kv.each do |_, v|
    populate_query +=
      "(#{v[0]}, '#{v[1]}', #{list_of_regions.include? v[1]}, NOW(), NOW()), "
  end

  populate_query.chomp!(', ') << ';'
  conn.exec(populate_query)

  # Step 03. Reread `studies.csv`, adding to join table whenever a study occurred at a site
  CSV.foreach(path_to_csv, headers: true) do |row|
    initial_regions_kv.each do |k, v|
      next unless row[k] == '1.00'

      conn.exec("INSERT INTO sites_studies(study_id, site_id) VALUES (#{row['StudyID']}, #{v[0]})")
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
