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
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @manifest = Manifest.find(params[:id])
    @comments = ManifestComment.where(manifest_id: params[:id]).order(:created_at)
  end

  def edit
    @manifest_tag = ManifestTag.new
    @manifest = Manifest.find(params[:id])
    @tag_names = Tag.find_tag(@manifest)
  end

  def update
    @manifest = ManifestTag.new(manifest_params)
    if @manifest.valid?
      @manifest.update(params[:id])
      redirect_to manifest_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    manifest = ManifestTag.new
    if manifest.destroy(params[:id])
      redirect_to root_path
    else
      render :show
    end
  end

  # タグ検索用のメソッド
  def search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
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
