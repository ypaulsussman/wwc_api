# frozen_string_literal: true

# READ BEFORE USING! Call this with envvars for each of the three CSV's you'd like to import:
# e.g. $ rails db:reset findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv
# to only populate the `findings` (and its fk-dependent) tables

require 'csv'
require_relative 'wwc_scrubbers/findings_scrubber.rb'

if ENV['findings'].present?
  # Scrub downloaded CSV
  @findings_scrubber.scrub ENV['findings']

  # We don't care about...
  #   Intervention_Name, Outcome_Measure (provided on their own tables), or
  #   Protocol (useless w/o accompanying Protocol_Version, as in Studies and InterventionReports)
  FINDINGS_ATTRS =
    ['Comparison', 'Outcome_Domain', 'Period', 'Sample_Description', 'Is_Subgroup',
     'Outcome_Sample_Size', 'Outcome_Measure_Intervention_Sample_Size',
     'Outcome_Measure_Comparison_Sample_Size', 'Intervention_Clusters_Sample_Size',
     'Comparison_Clusters_Sample_Size', 'Intervention_Mean', 'Comparison_Mean',
     'Intervention_Standard_Deviation', 'Comparison_Standard_Deviation', 'Effect_Size_Study',
     'Effect_Size_WWC', 'Improvement_Index', 'p_Value_Study', 'p_Value_WWC', 'ICC',
     'Clusters_Total', 'Is_Statistically_Significant', 'Finding_Rating', 'ESSA_Rating',
     'L1_Unit_of_Analysis'].freeze

  ## Import `findings`
  CSV.foreach('db/findings_formatted.csv', headers: true) do |row|
    finding = Finding.new
    finding.id = row['FindingID']
    finding.outcome_measure =
      OutcomeMeasure.find_or_create_by(id: row['OutcomeMeasureID'], name: row['Outcome_Measure'])
    finding.intervention =
      Intervention.find_or_create_by(id: row['InterventionID'], name: row['Intervention_Name'])
    finding.review =
      Review.find_or_create_by(id: row['ReviewID'])

    FINDINGS_ATTRS.each do |attr|
      finding[attr.downcase] = row[attr]
    end

    finding.save!
  rescue StandardError => e
    puts "Finding #{finding.id} generated: " + e
  end
end
