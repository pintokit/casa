module Api::V1
  class FlatsController < ApiController

    # GET /v1/flats/:hirise
    def api
      case params[:hirise]
      when 'nema'
        render json: Flat.joins(:floorplan).where(floorplans: {hirise: :nema}), each_serializer: FlatSerializer
      when 'jasper'
        render json: Flat.joins(:floorplan).where(floorplans: {hirise: :jasper}), each_serializer: FlatSerializer
      else
        render json: Flat.all, each_serializer: FlatSerializer
      end
    end
  end
end
