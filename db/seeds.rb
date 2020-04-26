# frozen_string_literal: true

# READ BEFORE USING! Call this with envvars for each of the three CSV's you'd like to import:
# e.g. $ rails db:reset findings=db/WWC-export-archive-2020-Apr-25-142355/Findings.csv
# to only populate the `findings` (and its fk-dependent) tables

require 'csv'
require_relative 'wwc_scrubbers/studies_scrubber.rb'
require_relative 'wwc_scrubbers/findings_scrubber.rb'

if ENV['studies'].present?
  # Scrub downloaded CSV
  @studies_scrubber.scrub ENV['studies']

  # No records appear to have values for `US_Region_U_S__Region`, `School_setting_Student_Count`,
  # `Disability_Autism_spectrum_disorder`, `Disability_Individualized_Education_Plan__IEP_`,
  # `Demographics_of_Study_Sample_Minority`, `Demographics_of_Study_Sample_Non_minority`, and
  # `Demographics_of_Study_Sample_Students_with_disabilities` -- so skipping these fields.

  # In addition, postponing other set-based boolean fields until you've resolved (join-table vs enum
  # vs standard denormalized string) for each set.

  # posting_date:date study_rating:text rating_reason:text ineligibility_reason:text

  REVIEW_ATTRS =
    ['Standards_Version', 'Purpose_of_Review', 'Posting_Date', 'Study_Rating', 'Rating_Reason',
     'Ineligibility_Reason'].freeze
  STUDY_ATTRS =
    [].freeze

  ## Import `reviews` and `studies`
  CSV.foreach('db/findings_formatted.csv', headers: true) do |row|
    # 02 grab all data to find/create Review
    review = Review.new
    review.id = row['ReviewID']
    review.product =
      Product.find_or_create_by(id: row['ProductID'], name: row['Product_Name'])
    review.protocol =
      Protocol.find_or_create_by(name: row['Protocol'], version: row['Protocol_Version'])

    REVIEW_ATTRS.each do |attr|
      review[attr.downcase] = row[attr]
    end
    review.save!

    # 03 grab all data to find/create Study
    study = Study.new
    study.id = row['StudyID']
    study.review = Review.find_or_create_by(id: row['ReviewID'])

    if row['Demographics_of_Study_Sample_International'] == '1.00'
      study.demographics_of_study_sample_international = true
    else
      study.demographics_of_study_sample_international = false
    end

    STUDY_ATTRS.each do |attr|
      study[attr.downcase] = row[attr]
    end
    study.save!
  rescue StandardError => e
    puts "Finding #{finding.id} generated: " + e
  end
end

# THEN: diff against second branch to create Finding:Review relationship; add below
if ENV['findings'].present?
  # Scrub downloaded CSV
  @findings_scrubber.scrub ENV['findings']

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

  ## Import `findings`
  CSV.foreach('db/findings_formatted.csv', headers: true) do |row|
    finding = Finding.new
    finding.id = row['FindingID']
    finding.outcome_measure =
      OutcomeMeasure.find_or_create_by(id: row['OutcomeMeasureID'], name: row['Outcome_Measure'])
    finding.intervention =
      Intervention.find_or_create_by(id: row['InterventionID'], name: row['Intervention_Name'])

    FINDING_ATTRS.each do |attr|
      finding[attr.downcase] = row[attr]
    end

    finding.save!
  rescue StandardError => e
    puts "Finding #{finding.id} generated: " + e
  end
end
