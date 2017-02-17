class ListingsController < ApplicationController
  before_action :set_flat, only: :index

  # GET /flats/:flat_id/listings
  def index
    @listings = @flat.listings.last(10)
    
    week_range = "(DATE_TRUNC('week', (created_at::timestamptz - INTERVAL '6 day' - INTERVAL '0 second') AT TIME ZONE 'Etc/UTC') + INTERVAL '6 day' + INTERVAL '0 second') AT TIME ZONE 'Etc/UTC'"
    price_query = "SELECT #{week_range} AS created_at, listings.flat_id, avg(listings.price) AS avg_price FROM listings WHERE listings.flat_id = #{@flat.id} AND listings.price > 0 GROUP BY listings.flat_id, #{week_range} ORDER BY created_at ASC;"
    @results = Listing.connection.execute(price_query, :skip_logging)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:flat_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:flat, :price)
    end
end
