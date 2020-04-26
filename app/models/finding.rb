# frozen_string_literal: true

class Finding < ApplicationRecord
  belongs_to :intervention
  belongs_to :outcome_measure
  belongs_to :review
end
