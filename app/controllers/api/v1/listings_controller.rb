module Api::V1
  class ListingsController < ApiController

    # GET /v1/flats/1/listings
    def index
      render json: Listing.all, each_serializer: ListingSerializer
    end
  end
end
