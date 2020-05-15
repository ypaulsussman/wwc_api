# frozen_string_literal: true

class StudySearchesController < ApplicationController
  def create
    # start with author/title/publication=
    # render Study.prefiltered(request.request_parameters).fts(request.query_parameters)

    results = Study.fts(request.request_parameters, request.query_parameters)
    render json: { "count": results.length, "the_good_stuff": results }
  end

  def autocomplete
    puts params.inspect
    render json: params
  end
end
