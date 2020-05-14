# frozen_string_literal: true

class StudySearchesController < ApplicationController
  def create
    puts params.inspect
    render json: params
  end

  def autocomplete
    puts params.inspect
    render json: params
  end
end
