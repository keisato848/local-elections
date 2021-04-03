class AssemblymenController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :find_assemblyman, only: [:show, :edit, :update]

  def index
    @council = Council.find(params[:council_id])
    @assemblymen = Assemblyman.where(council_id: params[:council_id])
  end
  
  def show
    @comments = Comment.where(assemblyman_id: params[:id])
  end

  def search
    before_search
    search_params
  end

  def search_result
    if params[:faction].empty? && params[:sex].empty?
      before_search
      render 'search'
      search_params
    else
      @both_match = Assemblyman.where(council_id: params[:council_id], faction: params[:faction], sex: params[:sex])
      @faction_match = Assemblyman.where(council_id: params[:council_id], faction: params[:faction])
      @sex_match = Assemblyman.where(council_id: params[:council_id], sex: params[:sex])
    end
  end

  def edit
  end

  def update
    if @assemblyman.update(assemblyman_params)
      redirect_to "/prefectures/#{@assemblyman.council.prefecture.id}/councils/#{@assemblyman.council.id}/assemblymen/#{@assemblyman.id}"
    else
      render :edit
    end
  end

  private

  def find_assemblyman
    @assemblyman = Assemblyman.find(params[:id])
  end

  def assemblyman_params
    params.require(:assemblyman).permit(:name, :sex, :birth_of_date, :position, :faction, :number_of_wins, :job, :img_url,
                                        :twitter_url).merge(user_id: current_user.id)
  end

  def before_search
    @assemblymen = Assemblyman.where(council_id: params[:council_id])
    @factions = []
    @assemblymen.each do |assemblyman|
      @factions << assemblyman.faction
    end
  end
  
  def search_params
    params.permit(:prefecture_id, :id, :faction, :sex, :job)
  end

end
