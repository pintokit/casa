module Api::V1
  class AllController < ApiController

    # GET /v1/all/:model_name
    def export
      expires_in 1.hours, public: :true
      case params[:model_name]
      when 'flats'
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatListingSerializer
      when 'floorplans'
        render json: Floorplan.all.order(:layout_id, :layout_version), each_serializer: AllFloorplanSerializer
      when 'scores'
        @flats = Flat.all.sort_by(&:value_score).reverse!
        render "application/_scores"
      else
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatListingSerializer
      end
    end

  end
end
