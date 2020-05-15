# frozen_string_literal: true

class Study < ApplicationRecord
  has_many :reviews
  has_many :findings, through: :reviews
  has_and_belongs_to_many :class_types
  has_and_belongs_to_many :delivery_methods
  has_and_belongs_to_many :grades
  has_and_belongs_to_many :program_types
  has_and_belongs_to_many :school_types
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :urbanicities

  class << self
    def fts(search_kv)
      text_search = all.left_outer_joins(:topics)
      search_kv.each do |search_key, search_string|
        unless %w[author title publication].include?(search_key)
          break { 'hey_choose': 'a real field' }
        end

        text_search =
          text_search.where("#{search_key}_fts @@ plainto_tsquery('english', ?)", search_string)
      end
      preposterous_select =
        'studies.id, studies.citation, studies.study_page_url,'\
        'studies.study_design, studies.ericid, array_agg(topics.name) as study_topics'

      text_search =
        text_search
        .group(:id, :citation, :study_page_url, :ericid, :study_design)
        .select(preposterous_select)
    end

    # def prefiltered(filter_kv)
    #   puts 'lol'
    #   return none if result = nil
    # end
  end
end
