class ManifestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :user_restrictions, only: [:edit, :update, :destroy]

  def new
    @manifest = ManifestTag.new
  end
  
  def create
    @manifest = ManifestTag.new(manifest_params)
    if @manifest.valid?
      @manifest.save
      return redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @manifest = Manifest.find(params[:id])
  end
  
  def edit
    @manifest_tag = ManifestTag.new
    @manifest = Manifest.find(params[:id])
    tags = Tag.find(@manifest.tag_ids)
    @tag_names = []
    tags.each do |tag|
      @tag_names.append(tag.name)
    end
  end
  
  def update
    @manifest = ManifestTag.new(manifest_params)
    if @manifest.valid?
      @manifest.update
      return redirect_to manifest_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    manifest_tag_relation = ManifestTagRelation.find_by(manifest_id: params[:id])
    manifest = Manifest.find(params[:id])
    if manifest.destroy
      redirect_to root_path
    else
      render :show
    end
  end
  
  def search
    return nil if params[:keyword] == ''
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  
  private
  
  def manifest_params
    params.require(:manifest_tag).permit(:title, :description, :name).merge(user_id: current_user.id)
  end
  
  def user_restrictions
    manifest = Manifest.find(params[:id])
    redirect_to root_path if current_user.id != manifest.user.id
  end
end
