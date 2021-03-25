class AssemblymenController < ApplicationController
  before_action :search_comment, only: :show
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    find_assemblyman
  end

  def edit
    find_assemblyman
  end

  def update
    find_assemblyman
    if @assemblyman.update(assemblyman_params)
      redirect_to "/prefectures/#{@assemblyman.council.prefecture.id}/councils/#{@assemblyman.council.id}/assemblymen/#{@assemblyman.id}"
    else
      render :edit
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
    params.require(:assemblyman).permit(:name, :sex, :birth_of_date, :position, :faction, :number_of_wins, :job, :img_url,
                                        :twitter_url).merge(user_id: current_user.id)
  end
end
