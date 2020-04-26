# frozen_string_literal: true

# This is going to be a slog to periodically update, but
# I don't have the skills/time for the equivalent regex... YET
MALFORMED_FINDINGS_TOKENS =
  ['Shy', 'being in a group', 'appropriate', 'inappropriate', 'sharing', 'feeder',
   'C', 'Types', 'equivalent', 'Methods', 'More decodable', 'Other', 'Non-White',
   'Mac Gets Well'].freeze

def @findings_data.scrub(path_to_csv)
  File.delete('db/findings_formatted.csv') if File.exist?('db/findings_formatted.csv')

  # Stream don't slurp, in case... we decide to run this on an Arduino later?
  File.foreach(path_to_csv) do |row, row_num|
    # Clean up spacing
    row.gsub!(/[ ]+/, ' ')

    # Replace instances of CSV-breaking double-quotes
    MALFORMED_FINDINGS_TOKENS.each do |token|
      row.gsub!("\"#{token}\"", "\'#{token}\'")
    end

    File.write('db/findings_formatted.csv', row, mode: 'a+')
  rescue StandardError => e
    puts "Unformatted finding-row #{row_num} generated: " + e
  end
end
