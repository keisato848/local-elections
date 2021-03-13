class AssemblymenController < ApplicationController
  before_action :search_comment
  def show
    @assemblyman = Assemblyman.find_by(id: params[:id])
  end

  private

  def search_comment
    @comments = Comment.where(assemblyman_id: params[:id])
  end
end
