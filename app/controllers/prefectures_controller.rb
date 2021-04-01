class PrefecturesController < ApplicationController
  def index
    @manifests = Manifest.last(5).sort{|a, b| b <=> a }
  end
  def show
    @prefecture = Prefecture.find(params[:id])
    @councils = Council.where(prefecture_id: params[:id])
  end
end
