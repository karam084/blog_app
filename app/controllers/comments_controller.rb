class CommentsController < ApplicationController
  def create
    @user = Post.find(params[:user_id])
    @post = Post.find(params[:user_id])
    @comment = Comment.new(post_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def new
    @comment = Comment.new
  end

  def delete
    @comment = Comment.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Comment Deleted!' }
    end
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
