class Api::V1::BaseController < ApplicationController
  respond_to :json
  include ErrorControl
end