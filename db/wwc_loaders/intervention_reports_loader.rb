# frozen_string_literal: true

# See db/wwc_loaders/studies_loader.rb for reasoning behind excluded fields
REPORT_ATTRS = ['Outcome_Domain', 'NumStudiesMeetingStandards', 'NumStudiesEligible',
                'Sample_Size_Intervention', 'Effectiveness_Rating'].freeze

def @reports_data.load
  CSV.foreach('db/reports_formatted.csv', headers: true) do |row|
    report = InterventionReport.new

    # This is the only table with interventions' URL's, but it's also the last loaded.
    if (i = Intervention.find_by(wwcid: row['InterventionID'], name: row['Intervention_Name']))
      i.update!(wwc_url: row['Intervention_Page_URL'])
      report.intervention = i
    else
      report.intervention = Intervention.create!(
        wwcid: row['InterventionID'],
        name: row['Intervention_Name'],
        wwc_url: row['Intervention_Page_URL']
      )
    end

    report.protocol =
      Protocol.find_or_create_by!(name: row['Protocol'], version: row['Protocol_Version'])

    REPORT_ATTRS.each do |attr|
      report[attr.downcase] = row[attr]
    end

    report.save!
  end
end
