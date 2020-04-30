# frozen_string_literal: true

class DeliveryMethod < ApplicationRecord
  has_and_belongs_to_many :studies
end
