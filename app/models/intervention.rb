# frozen_string_literal: true

class Intervention < ApplicationRecord
  has_many :findings
end
