class AssemblymenController < ApplicationController

  def show
    @assemblyman = Assemblyman.find_by(id: params[:id])
    @comments = Comment.where(assemblyman_id: params[:id])
  end
  
end
