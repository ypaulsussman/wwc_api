# frozen_string_literal: true

# We don't care about...
#   Intervention_Name, Outcome_Measure (provided on their own tables), or
#   Protocol (useless w/o accompanying Protocol_Version, as in Studies and InterventionReports)
FINDING_ATTRS =
  ['Comparison', 'Outcome_Domain', 'Period', 'Sample_Description', 'Is_Subgroup',
   'Outcome_Sample_Size', 'Outcome_Measure_Intervention_Sample_Size',
   'Outcome_Measure_Comparison_Sample_Size', 'Intervention_Clusters_Sample_Size',
   'Comparison_Clusters_Sample_Size', 'Intervention_Mean', 'Comparison_Mean',
   'Intervention_Standard_Deviation', 'Comparison_Standard_Deviation', 'Effect_Size_Study',
   'Effect_Size_WWC', 'Improvement_Index', 'p_Value_Study', 'p_Value_WWC', 'ICC',
   'Clusters_Total', 'Is_Statistically_Significant', 'Finding_Rating', 'ESSA_Rating',
   'L1_Unit_of_Analysis'].freeze

def @findings_data.load
  CSV.foreach('db/findings_formatted.csv', headers: true) do |row|
    finding = Finding.new
    finding.id = row['FindingID']

    finding.intervention =
      Intervention.find_or_create_by!(wwcid: row['InterventionID'], name: row['Intervention_Name'])
    finding.outcome_measure =
      OutcomeMeasure.find_or_create_by!(id: row['OutcomeMeasureID'], name: row['Outcome_Measure'])
    finding.review =
      Review.find_or_create_by!(id: row['ReviewID'])

    FINDING_ATTRS.each do |attr|
      finding[attr.downcase] = row[attr]
    end

    finding.save!
  rescue StandardError => e
    puts "Finding #{finding.id} generated: " + e
  end
end
