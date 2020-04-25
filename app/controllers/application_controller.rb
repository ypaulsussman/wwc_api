# frozen_string_literal: true

require 'json_web_token'

class ApplicationController < ActionController::API
  # Reenable, if needed, w/ tokens_controller.rb#L5
  # before_action :authenticate_request

  def initialize
    @current_user = nil
    @errors = {}
  end

  def lander
    render json: { 'bro': 'sup!' }
  end

  private

  def authenticate_request
    @current_user = find_user

    render(json: { error: @errors }, status: 401) unless @current_user
  end

  def find_user
    token = JsonWebToken.decode(auth_header)
    return User.find(token[:user_id]) if token.present?

    @errors[:token] ||= 'Invalid'
    nil
  end

  def auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end

    @errors[:token] = 'Missing'
    nil
  end
end
