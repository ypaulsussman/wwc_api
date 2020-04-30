# frozen_string_literal: true

class Grade < ApplicationRecord
  has_and_belongs_to_many :studies
end
