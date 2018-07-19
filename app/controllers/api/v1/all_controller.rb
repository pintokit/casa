module Api::V1
  class AllController < ApiController

    # GET /v1/all/:model_name
    def export
      case params[:model_name]
      when 'flats'
        expires_in 1.hours, public: :true
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatListingSerializer
      when 'floorplans'
        expires_in 1.hours, public: :true
        render json: Floorplan.all.order(:layout_id, :layout_version), each_serializer: AllFloorplanSerializer
      when 'scores'
        expires_in 1.hours, public: :true
        @flats = Flat.all.sort_by(&:value_score).reverse!
        render "application/_scores"
      else
        expires_in 1.hours, public: :true
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatListingSerializer
      end
    end

  end
end
