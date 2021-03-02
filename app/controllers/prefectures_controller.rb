class PrefecturesController < ApplicationController
  def show
    @prefecture = Prefecture.find(params[:id])
    @governors = Council.where("name LIKE ? AND prefecture_id LIKE ?", "%首長%", "#{params[:id]}")
    @councils = Council.where(prefecture_id: params[:id])
  end
end
