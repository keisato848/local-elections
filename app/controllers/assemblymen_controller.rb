class AssemblymenController < ApplicationController
  before_action :find_council, :find_assemblyman, :find_assemblymen
  
  def index
  end
  
  def show
  end
  
  
  private
  def find_council
    @council = Council.find_by(id: params[:council_id])
  end
  def find_assemblyman
    @assemblyman = Assemblyman.find_by(council_id: params[:council_id])
  end
  
  def find_assemblymen
    @assemblymen = Assemblyman.where(council_id: params[:council_id])
  end
end
