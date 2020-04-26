# frozen_string_literal: true

class Review < ApplicationRecord
  has_many :findings
end
