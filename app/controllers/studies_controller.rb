# frozen_string_literal: true

class StudiesController < ApplicationController
  def index
    render json: File.read('app/controllers/concerns/fts_initial_filters.json')
  end

  def show; end
  # ...for now!
end
