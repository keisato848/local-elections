class ManifestCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_manifest, only: :new 
  def new
    @comment = ManifestComment.new
  end

  def create
    @comment = ManifestComment.new(comment_params)
    if @comment.save
      redirect_to manifest_path(params[:manifest_id])
    else
      render :new
    end
  end

  def destroy
    comment = ManifestComment.find(params[:id])
    if current_user.id == comment.user.id
      comment.destroy!
      redirect_to manifest_path(params[:manifest_id])
    else
      redirect_to root_path
    end
  end

  private

  def set_manifest
    @manifest = Manifest.find_by(id: params[:manifest_id])
  end

  def comment_params
    params.require(:manifest_comment).permit(:content).merge(user_id: current_user.id, manifest_id: params[:manifest_id])
  end
end
