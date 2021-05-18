class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @manifests = Manifest.all.includes(:tags).order(updated_at: 'DESC')
    @questions = Question.all.includes(:tags).order(updated_at: 'DESC')
  end
end
