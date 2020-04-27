# frozen_string_literal: true

class Intervention < ApplicationRecord
  has_many :reviews
  has_many :findings
  has_many :intervention_reports
end
