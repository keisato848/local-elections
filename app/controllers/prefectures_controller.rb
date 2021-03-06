class PrefecturesController < ApplicationController
  def show
    @prefecture = Prefecture.find(params[:id])
    @councils = Council.where(prefecture_id: params[:id])
  end
end
