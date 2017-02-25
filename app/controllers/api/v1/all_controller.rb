module Api::V1
  class AllController < ApiController

    # GET /v1/all/flats
    def export
      case params[:model_name]
      when 'flats'
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatSerializer
      when 'floorplans'
        render json: Floorplan.all.order(:layout_id), each_serializer: AllFloorplanSerializer
      else
        render json: Flat.all.sort_by(&:value_score).reverse!, each_serializer: AllFlatSerializer
      end
    end

  end
end
