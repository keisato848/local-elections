class AssemblymenController < ApplicationController
  before_action :search_comment, only: :show
  def show
    find_assemblyman
  end
  def edit
    find_assemblyman
  end
  def update
    find_assemblyman
    if @assemblyman.update(assemblyman_params)
      redirect_to prefecture_council_assemblyman_path(params[:id])
    else
      find_assemblyman
      render :update
    end
  end

  private
  def find_assemblyman
    @assemblyman = Assemblyman.find_by(id: params[:id])
  end
  def search_comment
    @comments = Comment.where(assemblyman_id: params[:id])
  end
  def assemblyman_params
    params.require(:assemblyman).permit(:name, :sex, :birth_of_date, :position, :faction, :number_of_wins, :job, :img_url, :twitter_url)
  end
end
