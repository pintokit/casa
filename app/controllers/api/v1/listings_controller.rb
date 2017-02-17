module Api::V1
  class ListingsController < ApiController

    # GET /v1/flats/:flat_id/listings
    def index
      render json: Listing.all, each_serializer: ListingSerializer
    end
  end
end
