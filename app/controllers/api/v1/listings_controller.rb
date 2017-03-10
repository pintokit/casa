module Api::V1
  class ListingsController < ApiController
    before_action :set_flat

    # GET /v1/listings/1
    def api
      render json: @flat.listings, each_serializer: ListingSerializer
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_flat
        @flat = Flat.find(params[:flat_id])
      end

  end
end
