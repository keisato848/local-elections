class PrefecturesController < ApplicationController
  def index
    @manifests = Manifest.last(5).sort { |a, b| b <=> a }
    @questions = Question.last(5).sort { |a, b| b <=> a }
  end
end
