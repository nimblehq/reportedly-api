# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  include Localization
  include ActionController::MimeResponds
end
