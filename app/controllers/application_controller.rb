class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_html_or_json(object)
    respond_to do |format|
        format.html
        format.json { render json: object }
    end
  end
end
