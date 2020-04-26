# frozen_string_literal: true

@studies_scrubber = Object.new

def @studies_scrubber.scrub(path_to_csv)
  File.foreach(path_to_csv) do |row, row_num|
    # Clean up spacing
    row.gsub!(/[ ]+/, ' ')

    # Remove unescaped HTML quotes
    row.gsub!(/["]+>/, '\'>')
    row.gsub!(/=["]+/, '=\'')

    # Remove cases of double...double...quoting
    row.gsub!(/""at or above grade level""/, '\'at or above grade level\'')
    row.gsub!(/""low touch""/, '\'low touch\'')
    row.gsub!(/""CW-FIT""/, '\'CW-FIT\'')

    File.write('db/studies_formatted.csv', row, mode: 'a+')
  rescue StandardError => e
    puts "Row #{row_num} generated: " + e
  end
end
