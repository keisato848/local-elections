class CouncilsController < ApplicationController
  def index
    @prefecture = Prefecture.find_by_id params[:prefecture_id]
    @councils = Council.where(prefecture_id: params[:prefecture_id])
  end
end
