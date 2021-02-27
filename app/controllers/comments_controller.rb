class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @assemblyman = Assemblyman.find_by(id: params[:assemblyman_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{params[:assemblyman_id]}"
    else
      @assemblyman = Assemblyman.find_by(id: params[:assemblyman_id])
      render :new
    end
  end

  private

  def comment_params
    params.permit(:comment).merge(user_id: current_user.id, assemblyman_id: params[:assemblyman_id])
  end
end
