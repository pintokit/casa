module Api::V1
  class ListingsController < ApiController
    before_action :set_flat, only: :index

    # GET /v1/flats/1/listings
    def index
      render json: @flat.listings, each_serializer: ListingSerializer
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_flat
        @flat = Flat.find(params[:flat_id])
      end

  end
end
