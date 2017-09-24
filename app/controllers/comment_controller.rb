class CommentController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(context: params[:comment][:context])
    @comment.publication_id = params[:comment][:publication_id]
    @comment.user_id = current_user.id
    if @comment.save
       @is_saved = true
    else
      @is_saved = false
    end
  end

  def edit
  end

  def delete
  end

end
