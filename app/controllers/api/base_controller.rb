# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    before_action :set_default_format

    private

    def set_default_format
      request.format = :json
    end
  end
end
