# frozen_string_literal: true

# READ BEFORE USING! Call this with envvars for each of the three CSV's you'd like to import:
# e.g. $ rails db:reset findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv
# to only populate the `findings` (and its fk-dependent) tables

require 'csv'

# Don't need instancing (Class) or reuse across files (Module)
@studies_data = Object.new
@findings_data = Object.new
@reports_data = Object.new

# Add the scrub/load methods to the *_data objects
require_relative 'wwc_scrubbers/studies_scrubber.rb'
require_relative 'wwc_scrubbers/findings_scrubber.rb'
require_relative 'wwc_scrubbers/intervention_reports_scrubber.rb'

require_relative 'wwc_loaders/studies_loader.rb'
require_relative 'wwc_loaders/findings_loader.rb'
require_relative 'wwc_loaders/intervention_reports_loader.rb'

require_relative 'wwc_additions/study_site_transformer.rb'
require_relative 'wwc_additions/bool_sets_transformer.rb'

if ENV['studies'].present?
  @studies_data.scrub ENV['studies']
  @studies_data.load
  @studies_data.add_sites 'db/studies_formatted.csv', 'wwc_api_development'
  @studies_data.add_boolean_sets 'db/studies_formatted.csv', 'wwc_api_development'
  File.delete('db/studies_formatted.csv') if File.exist?('db/studies_formatted.csv')
end

if ENV['findings'].present?
  @findings_data.scrub ENV['findings']
  @findings_data.load
  File.delete('db/findings_formatted.csv') if File.exist?('db/findings_formatted.csv')
end

if ENV['reports'].present?
  @reports_data.scrub ENV['reports']
  @reports_data.load
  File.delete('db/reports_formatted.csv') if File.exist?('db/reports_formatted.csv')
end
