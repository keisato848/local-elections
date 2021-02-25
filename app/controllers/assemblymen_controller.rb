class AssemblymenController < ApplicationController
  def index
    @council = Council.find_by(id: params[:council_id])
    @assemblyman = Assemblyman.find_by(council_id: params[:council_id])
    @assemblymen = Assemblyman.where(council_id: params[:council_id])
  end
end
