# frozen_string_literal: true

# This is going to be a slog to periodically update, but
# I don't have the skills/time for the equivalent regex... YET
MALFORMED_FINDINGS_TOKENS =
  ['Shy', 'being in a group', 'appropriate', 'inappropriate', 'sharing', 'feeder',
   'C', 'Types', 'equivalent', 'Methods', 'More decodable', 'Other', 'Non-White',
   'Mac Gets Well'].freeze

@findings_scrubber = Object.new

def @findings_scrubber.scrub(path_to_csv)
  # Stream don't slurp, in case... we decide to run this on an Arduino later?
  File.foreach(path_to_csv) do |row, row_num|
    # Clean up spacing
    row.gsub!(/[ ]+/, ' ')

    # Replace instances of problematic double-quoting
    MALFORMED_FINDINGS_TOKENS.each do |token|
      row.gsub!("\"#{token}\"", "\'#{token}\'")
    end

    File.write('db/findings_formatted.csv', row, mode: 'a+')
  rescue StandardError => e
    puts "Row #{row_num} generated: " + e
  end
end
