class ManifestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @manifest = ManifestTag.new
  end

  def create
    @manifest = ManifestTag.new(manifest_params)
    if @manifest.valid?
      @manifest.save
      return redirect_to root_path
    else
      render 'new'
    end
  end

  def search
    return nil if params[:keyword] == ''
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}"])
    render json:{ keyword: tag }
  end

  private

  def manifest_params
    params.require(:manifest_tag).permit(:title, :description, :name).merge(user_id: current_user.id)
  end
end
