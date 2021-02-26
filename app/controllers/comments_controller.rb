class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{params[:assemblyman_id]}", class: 'back-to-assemblymen-list'
    else
      render 'assemblymen/show'
    end
  end

  private
  def comment_params
    params.permit(:comment).merge(user_id: current_user.id, assemblyman_id: params[:assemblyman_id])
  end
end
