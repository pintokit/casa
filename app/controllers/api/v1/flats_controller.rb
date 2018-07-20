module Api::V1
  class FlatsController < ApiController

    # GET /v1/flats/:hirise
    def api
      case params[:hirise]
      when 'nema'
        expires_in 1.hours, public: :true
        render json: Flat.joins(:floorplan).where(floorplans: {hirise: :nema}), each_serializer: FlatSerializer
      when 'jasper'
        expires_in 1.hours, public: :true
        render json: Flat.joins(:floorplan).where(floorplans: {hirise: :jasper}), each_serializer: FlatSerializer
      else
        expires_in 1.hours, public: :true
        render json: Flat.all, each_serializer: FlatSerializer
      end
    end
  end
end
