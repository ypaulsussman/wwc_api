# frozen_string_literal: true

# No records appear to have values for `US_Region_U_S__Region`, `School_setting_Student_Count`,
# `Disability_Autism_spectrum_disorder`, `Disability_Individualized_Education_Plan__IEP_`,
# `Demographics_of_Study_Sample_Minority`, `Demographics_of_Study_Sample_Non_minority`, and
# `Demographics_of_Study_Sample_Students_with_disabilities` -- so skipping these fields.

# In addition, don't add other set-based boolean fields until you've resolved how to normalize
# (join-table vs enum vs standard denormalized string) each set.

# The following attributes from the `studies` CSV *appear* to be unique to a ReviewID, not a
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

def @studies_data.load
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

    # `wwcid` for Intervention and Product records is a hack, because neither appears usable as a pk
    # with the context provided by the CSV's.
    # Multiple InterventionID's match the same Intervention_Name; some names are provided without an
    # no id; some names occur identically both with and without an id...
    # ProductID is more tractable, but there are ~10 cases where a single ID matches multiple names.
    # No ID provided for protocols, so let the DB manage their generation.
    review.intervention =
      Intervention.find_or_create_by!(wwcid: row['InterventionID'], name: row['Intervention_Name'])
    review.product =
      Product.find_or_create_by!(wwcid: row['ProductID'], name: row['Product_Name'])
    review.protocol =
      Protocol.find_or_create_by!(name: row['Protocol'], version: row['Protocol_Version'])
    review.study = Study.find(row['StudyID'])

    REVIEW_ATTRS.each { |attr| review[attr.downcase] = row[attr] }
    review.save!

  rescue StandardError => e
    puts "Study #{study.id} generated: " + e
  end
end
