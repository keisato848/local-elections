class PrefecturesController < ApplicationController
  def index
    @manifests = Manifest.last(5)
  end
  def show
    @prefecture = Prefecture.find(params[:id])
    @councils = Council.where(prefecture_id: params[:id])
  end
end
