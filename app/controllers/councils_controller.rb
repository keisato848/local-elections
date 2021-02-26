class CouncilsController < ApplicationController
  def show
    @council = Council.find_by(id: params[:id])
    @assemblyman = Assemblyman.find_by(council_id: params[:id])
    @assemblymen = Assemblyman.where(council_id: params[:id])
  end
end
