# frozen_string_literal: true

class StudySearchesController < ApplicationController
  def create
    results = Study.fts(request.request_parameters, request.query_parameters)
    render json: { "count": results.length, "the_good_stuff": results }
  end

  def autocomplete
    puts params.inspect
    render json: params
  end
end
