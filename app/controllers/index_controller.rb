class IndexController < ApplicationController
  def index
    @publications = Publication.all
  end
end
