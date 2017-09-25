class CommentController < ApplicationController
  def new
  end

  def create
    @publication = Publication.where(publication_id: params[:comment][:publication_id]).first
    @publication.build_comment(
      comment: params[:comment][:context],
      publication_id: params[:comment][:publication_id],
      user_id: current_user.id)
  end

  def edit
  end

  def delete
  end

end
