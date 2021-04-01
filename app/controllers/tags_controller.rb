class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @manifests = Manifest.where(id: @tag.manifest_ids)
  end
end
