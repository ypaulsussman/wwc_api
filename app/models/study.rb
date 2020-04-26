# frozen_string_literal: true

class Study < ApplicationRecord
  has_many :reviews
  has_many :findings, through: :reviews
end
