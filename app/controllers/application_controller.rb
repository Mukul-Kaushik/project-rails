# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'soami', password: 'soamic'
  before_action :authenticate_user!
end
