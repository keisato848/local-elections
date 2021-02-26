class AssemblymenController < ApplicationController

  def show
    @assemblyman = Assemblyman.find_by(id: params[:id])
  end
  
end
