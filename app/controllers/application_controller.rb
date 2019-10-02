# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonApiResponders
  include JsonApiStandard
end
