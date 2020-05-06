# frozen_string_literal: true

class SearchableStudy < ApplicationRecord
  def readonly?
    true
  end
end
