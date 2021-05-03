class AssemblymanCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assemblyman, only: [:new]

  def new
    @comment = AssemblymanComment.new
  end

  def create
    @comment = AssemblymanComment.new(comment_params)
    if @comment.save
      redirect_to prefecture_council_assemblyman_path(id: params[:assemblyman_id])
    else
      set_assemblyman
      render :new
    end
  end

  def destroy
    comment = AssemblymanComment.find(params[:id])
    if current_user.id == comment.user.id
      comment.destroy!
      redirect_to prefecture_council_assemblyman_path(id: params[:assemblyman_id])
    else
      redirect_to root_path
    end
  end

  private

  def set_assemblyman
    @assemblyman = Assemblyman.find_by(id: params[:assemblyman_id])
  end

  def comment_params
    params.require(:assemblyman_comment).permit(:content).merge(user_id: current_user.id, assemblyman_id: params[:assemblyman_id])
  end
end
