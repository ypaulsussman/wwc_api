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

  # In addition, don't add other set-based boolean fields until you've resolved how to normalize
  # (join-table vs enum vs standard denormalized string) each set.

  # The following attributes from the `studies` CSV _appear_ to be unique to a ReviewID, not a
  # StudyID (and vice versa for the array following them) -- but I'm not 100% certain.
  REVIEW_ATTRS =
    ['Standards_Version', 'Purpose_of_Review', 'Posting_Date', 'Study_Rating', 'Rating_Reason',
     'Ineligibility_Reason'].freeze
  STUDY_ATTRS =
    ['Citation', 'Publication', 'Publication_Date', 'Study_Page_URL', 'Study_Design', 'ERICId',
     'Multisite', 'Demographics_of_Study_Sample_International',
     'Demographics_of_Study_Sample_English_language_learners',
     'Demographics_of_Study_Sample_Free_or_reduced_price_lunch', 'Ethnicity_Hispanic',
     'Ethnicity_Not_Hispanic', 'Race_Asian', 'Race_Black', 'Race_Native_American', 'Race_Other',
     'Race_Pacific_Islander', 'Race_White', 'Gender_Female', 'Gender_Male'].freeze

  ## Import `reviews` and `studies`
  CSV.foreach('db/studies_formatted.csv', headers: true) do |row|
    # ~12k unique studies; ~15k records in CSV
    unless Study.find_by(id: row['StudyID'])
      study = Study.new
      study.id = row['StudyID']

      # TODO: Replace, once you've created the 'full boolification' script
      if row['Demographics_of_Study_Sample_International'] == '1.00'
        study.demographics_of_study_sample_international = true
      else
        study.demographics_of_study_sample_international = false
      end

      STUDY_ATTRS.each { |attr| study[attr.downcase] = row[attr] }
      study.save!
    end

    # Create new Review
    review = Review.new
    review.id = row['ReviewID']

    # Across the findings/studies CSV's, multiple id's connect to the same name; some names have
    # no id; some names appear both with and without an id... TL;DR can't use InterventionID as pk
    review.intervention =
      Intervention.find_or_create_by!(wwcid: row['InterventionID'], name: row['Intervention_Name'])
    # Can't use ProductID as pk; there are ~10 cases where a single ID matches multiple names
    review.product =
      Product.find_or_create_by!(wwcid: row['ProductID'], name: row['Product_Name'])
    # No ID provided for protocols
    review.protocol =
      Protocol.find_or_create_by!(name: row['Protocol'], version: row['Protocol_Version'])
    review.study = Study.find(row['StudyID'])

    REVIEW_ATTRS.each { |attr| review[attr.downcase] = row[attr] }
    review.save!

  rescue StandardError => e
    puts "Study #{study.id} generated: " + e
  end

  puts 'Deleting formatted studies!'
  File.delete('db/studies_formatted.csv') if File.exist?('db/studies_formatted.csv')
end

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

  puts 'Deleting formatted findings!'
  File.delete('db/findings_formatted.csv') if File.exist?('db/findings_formatted.csv')
end
