class DashboardController < ApplicationController
  def index
    @publications = Publication.order(:person_name).page params[:page]
  end
end
