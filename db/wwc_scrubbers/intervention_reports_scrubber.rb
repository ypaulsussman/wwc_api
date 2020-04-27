# frozen_string_literal: true

def @reports_data.scrub(path_to_csv)
  File.delete('db/reports_formatted.csv') if File.exist?('db/reports_formatted.csv')

  File.foreach(path_to_csv) do |row, row_num|
    # Clean up spacing
    row.gsub!(/[ ]+/, ' ')

    File.write('db/reports_formatted.csv', row, mode: 'a+')
  rescue StandardError => e
    puts "Unformatted report-row #{row_num} generated: " + e
  end
end
