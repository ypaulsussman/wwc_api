# frozen_string_literal: true

class OutcomeMeasure < ApplicationRecord
  has_many :findings
end
