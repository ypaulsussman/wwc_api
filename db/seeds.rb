# frozen_string_literal: true

# READ BEFORE USING! Call this with envvars for each of the three CSV's you'd like to import:
# e.g. $ rails db:reset findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv
# to only populate the `findings` (and its fk-dependent) tables

require 'csv'

# Don't need instancing (Class) or reuse across files (Module)
@studies_data = Object.new
@findings_data = Object.new

# Add the scrub/load methods to the *_data objects
require_relative 'wwc_scrubbers/studies_scrubber.rb'
require_relative 'wwc_scrubbers/findings_scrubber.rb'
require_relative 'wwc_loaders/studies_loader.rb'
require_relative 'wwc_loaders/findings_loader.rb'

if ENV['studies'].present?
  @studies_data.scrub ENV['studies']
  @studies_data.load
  File.delete('db/studies_formatted.csv') if File.exist?('db/studies_formatted.csv')
end

if ENV['findings'].present?
  @findings_data.scrub ENV['findings']
  @findings_data.load
  File.delete('db/findings_formatted.csv') if File.exist?('db/findings_formatted.csv')
end
