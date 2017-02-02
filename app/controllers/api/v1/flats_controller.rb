class Api::V1::FlatsController < ApplicationController
  respond_to :json

  def index
    @flats = Flat.all
  end
end
