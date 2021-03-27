class ManifestsController < ApplicationController
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

  private

  def manifest_params
    params.require(:manifest_tag).permit(:title, :description, :name )
  end
end
