# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :protocol, optional: true
  belongs_to :intervention, optional: true
  has_many :findings
  has_many :studies
end
