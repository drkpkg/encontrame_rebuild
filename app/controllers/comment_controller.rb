class CommentController < ApplicationController
  def new
  end

  def create
    puts params[:publication_id]
    
    @comment = Comment.new()
    @comment.user_id = current_user.id
    @comment.context = params[:comment][:context]
    @comment.publication_id = params[:publication_id]
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
