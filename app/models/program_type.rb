# frozen_string_literal: true

class ProgramType < ApplicationRecord
  has_and_belongs_to_many :studies
end
