# frozen_string_literal: true

class Urbanicity < ApplicationRecord
  has_and_belongs_to_many :studies
end
