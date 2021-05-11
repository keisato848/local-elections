class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @manifests = Manifest.all.includes(:tags)
    @questions = Question.all.includes(:tags)
  end
end
