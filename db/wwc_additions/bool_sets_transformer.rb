# frozen_string_literal: true

require 'csv'
require 'pg'

# rubocop:disable all
def @studies_data.add_boolean_sets(path_to_csv, db_name)
  set_prefixes =
    ['Class_type', 'Delivery_Method', 'Grade', 'Program_Type', 'School_type', 'Urbanicity', 'Topic']

  bool_sets = {}
  set_prefixes.each do |prefix|
    bool_sets[prefix] = {}
  end

  headers = nil
  CSV.foreach(path_to_csv, headers: true, return_headers: true) do |row|
    headers = row.headers
    break
  end

  # Step 01. Create hash of each field 'in that set'/beginning with the prefix
  set_prefixes.each do |prefix|
    id_for_db = 0
    bool_sets[prefix] = headers.each_with_object({}) do |header, memo|
      next if prefix == 'Grade' && header == 'Topic_K_to_12th_Grade' # Kill me
      next unless header.include?(prefix)

      id_for_db += 1
      memo[header] = [id_for_db, header.sub("#{prefix}_", '').gsub(/_/, ' ')]
    end
  end
  # At this point,
  # bool_sets =
  #   { set_prefix :
  #     { og_csv_field_name: [id_for_db, 'name_for_db']}}

  # Step 02. Populate each set's table
  conn = PG.connect(dbname: db_name)
  bool_sets.each do |prefix, set|
    # ActivSupport inflectors had no time for any of these; go with the gnarly templating
    prefix = 'Urbanicitie' if prefix == 'Urbanicity'
    populate_query = "INSERT INTO #{prefix.downcase}s (id, name, created_at, updated_at) VALUES "
    set.each do |_, v|
      populate_query += "(#{v[0]}, #{conn.escape_literal(v[1])}, NOW(), NOW() ), "
    end
    populate_query.chomp!(', ') << ';'
    conn.exec(populate_query)
  end

  # Step 03. Reread `studies.csv`, adding to join table whenever a study occurred at a site
  bool_sets.each do |prefix, set|
    prefix_pl = if prefix == 'Urbanicity'
                  'Urbanicitie'
                else
                  prefix
                end

    join_table_name = if prefix.downcase < 'studies'
                        "#{prefix_pl.downcase}s_studies"
                      else
                        "studies_#{prefix_pl.downcase}s"
                      end

    CSV.foreach(path_to_csv, headers: true) do |row|
      set.each do |k, v|
        unless k.include?('Topic')
          next unless row[k] == '1.00'
        else
          next unless row[k] == '1'
        end

        conn.exec("INSERT INTO #{join_table_name}(study_id, #{prefix.downcase}_id) VALUES "\
        "(#{conn.escape_literal(row['StudyID'])}, #{v[0]})")
      end
    end

    remove_dupes = "DELETE FROM #{join_table_name} ss1 USING #{join_table_name} ss2 "\
      'WHERE ss1.ctid < ss2.ctid AND ss1.study_id = ss2.study_id '\
      "AND ss1.#{prefix.downcase}_id = ss2.#{prefix.downcase}_id"

    conn.exec(remove_dupes)
  end
end
# rubocop:enable all
