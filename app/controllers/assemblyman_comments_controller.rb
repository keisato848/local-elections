class AssemblymanCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assemblyman, only: [:new, :edit]

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

  def edit
    @comment = AssemblymanComment.find(params[:id])
  end

  def update
    @comment = AssemblymanComment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to prefecture_council_assemblyman_path(id: params[:assemblyman_id])
    else
      set_assemblyman
      render :edit
    end
  end

  def destroy
    comment = AssemblymanComment.find(params[:id])
    comment.destroy!
    redirect_to prefecture_council_assemblyman_path(id: params[:assemblyman_id])
  end

  private

  def set_assemblyman
    @assemblyman = Assemblyman.find_by(id: params[:assemblyman_id])
  end

  def comment_params
    params.require(:assemblyman_comment).permit(:content).merge(user_id: current_user.id, assemblyman_id: params[:assemblyman_id])
  end
end
