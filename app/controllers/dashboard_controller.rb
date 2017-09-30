class DashboardController < ApplicationController
  def index
    @publications = Publication.all
  end
end
