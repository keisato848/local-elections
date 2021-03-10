class CouncilsController < ApplicationController
  before_action :search_council
  
  def show
    @assemblyman = Assemblyman.find_by(council_id: params[:id])
    @assemblymen = Assemblyman.where(council_id: params[:id])
  end
  
  def search
    select_content
    search_params
  end
  
  def search_result
    if params[:faction].empty? && params[:sex].empty? && params[:job].empty?
      incorrect_search
    else
      search_target
    end
  end
    
  private
  def search_council
    @council = Council.find_by(id: params[:id])
  end

  def search_params
    params.permit(:prefecture_id, :id, :faction, :sex, :job)
  end

  def select_content
    @assemblymen = Assemblyman.where(council_id: params[:id])
    @factions = []
    @jobs = []
    @assemblymen.each do |item|
      @factions << item.faction
      @jobs << item.job
    end
  end

  def incorrect_search
    select_content
    search_params
    render :search
  end
  
  def search_target
    # フォームに入力された値を変数に格納
    faction = params[:faction]
    sex = params[:sex]
    job = params[:job]
    # すべての値が入力された場合
    if faction.present? && sex.present? && job.present?
      @all_match = Assemblyman.where(faction: faction, sex: sex, job: job)
      if @all_match.empty? 
        @faction_match = Assemblyman.where(faction: faction)
        @sex_match = Assemblyman.where(sex: sex)
        @job_match = Assemblyman.where(job: job)
      end
    # ２つの値が入力された場合
    elsif faction.empty? && (sex.present? && job.present?)
      @all_match = Assemblyman.where(sex: sex, job: job)
      if @all_match.empty? 
        @sex_match = Assemblyman.where(sex: sex)
        @job_match = Assemblyman.where(job: job)
      end
    elsif sex.empty? && (faction.present? && job.present?)
      @all_match = Assemblyman.where(faction: faction, job: job)
      if @all_match.empty? 
        @faction_match = Assemblyman.where(faction: faction)
        @job_match = Assemblyman.where(job: job)
      end
    elsif job.empty? && (faction.present? && sex.present?)
      @all_match = Assemblyman.where(faction: faction, sex: sex)
      if @all_match.empty? 
        @faction_match = Assemblyman.where(faction: faction)
        @sex_match = Assemblyman.where(sex: sex)
      end
    # １つしか値が入力されていない場合
    else
      @faction_match = Assemblyman.where(faction: faction)
      @sex_match = Assemblyman.where(sex: sex)
      @job_match = Assemblyman.where(job: job)
    end
  end
end
