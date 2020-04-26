# frozen_string_literal: true

@studies_scrubber = Object.new

def @studies_scrubber.scrub(path_to_csv)
  File.delete('db/studies_formatted.csv') if File.exist?('db/studies_formatted.csv')

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

    # No idea how common such occurrences are, but there are ~100 of the former and ~1000 of the
    # latter in the field; I'm _assuming_ they're meant to be one value and combining...
    row.gsub!(/Randomized controlled trial/, 'Randomized Controlled Trial')

    File.write('db/studies_formatted.csv', row, mode: 'a+')
  rescue StandardError => e
    puts "Unformatted study-row #{row_num} generated: " + e
  end
end
