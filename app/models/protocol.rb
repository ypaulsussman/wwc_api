# frozen_string_literal: true

class Protocol < ApplicationRecord
  has_many :reviews
  has_many :intervention_reports
end
