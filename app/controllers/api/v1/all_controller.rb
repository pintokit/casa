module Api::V1
  class AllController < ApiController

    # GET /v1/all/flats
    def export
      case params[:model_name]
      when 'flats'
        render json: Flat.all, each_serializer: AllFlatSerializer
      when 'floorplans'
        render json: Floorplan.all, each_serializer: AllFloorplanSerializer
      else
        render json: Flat.all, each_serializer: AllFlatSerializer
      end
    end

  end
end
