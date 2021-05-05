class SearchesController < ApplicationController
  def index
    if Assemblyman.search_correct?(params[:faction], params[:sex])
      @both_match = Assemblyman.where(council_id: params[:council_id], faction: params[:faction], sex: params[:sex])
      @faction_match = Assemblyman.where(council_id: params[:council_id], faction: params[:faction])
      @sex_match = Assemblyman.where(council_id: params[:council_id], sex: params[:sex])
    else
      redirect_to prefecture_council_assemblymen_path(prefecture_id: params[:prefecture_id], council_id: params[:council_id]),
                  notice: '検索条件を指定してください'
    end
  end
end
