class AssemblymenController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_assemblyman, only: [:show, :edit, :update]

  def index
    @council = Council.find(params[:council_id])
    @assemblymen = Assemblyman.where(council_id: params[:council_id])
    @factions = Assemblyman.setting_search(params[:council_id])
    search_params
  end

  def show
    @comments = AssemblymanComment.where(assemblyman_id: params[:id]).order(:created_at)
  end

  def edit
  end

  def update
    if @assemblyman.update(assemblyman_params)
      redirect_to prefecture_council_assemblyman_path(assemblyman: @assemblyman), notice: '議員情報を更新しました'
    else
      render :edit
    end
  end

  private

  def set_assemblyman
    @assemblyman = Assemblyman.find(params[:id])
  end

  def assemblyman_params
    params.require(:assemblyman).permit(:name, :sex, :birth_of_date, :position, :faction, :number_of_wins, :job, :img_url,
                                        :twitter_url).merge(user_id: current_user.id)
  end

  def search_params
    params.permit(:prefecture_id, :council_id, :faction, :sex)
  end
end
