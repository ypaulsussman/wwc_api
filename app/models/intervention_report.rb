# frozen_string_literal: true

class InterventionReport < ApplicationRecord
  belongs_to :intervention
  belongs_to :protocol, optional: true
end
