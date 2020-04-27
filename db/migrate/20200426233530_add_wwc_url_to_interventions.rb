# frozen_string_literal: true

class AddWwcUrlToInterventions < ActiveRecord::Migration[6.0]
  def change
    add_column :interventions, :wwc_url, :text
  end
end
