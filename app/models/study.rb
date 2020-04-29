# frozen_string_literal: true

class Study < ApplicationRecord
  has_and_belongs_to_many :sites
  has_many :reviews
  has_many :findings, through: :reviews
end
