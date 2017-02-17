module Api::V1
  class FlatsController < ApiController

    # GET /v1/flats
    def index
      render json: Flat.all, each_serializer: FlatSerializer
    end
  end
end
