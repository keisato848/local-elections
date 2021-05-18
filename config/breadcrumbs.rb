crumb :root do
  link "ホーム", root_path
end

crumb :prefecture do |prefecture|
  prefecture = Prefecture.find_by_id params[:prefecture_id]
  link prefecture.name, prefecture_councils_path(params[:prefecture_id])
  parent :root
end

crumb :council do |council|
  if params[:council_id]
    council = Council.find(params[:council_id])
  else
    council = Council.find(params[:council_id])
  end
  link council.name, prefecture_council_assemblymen_path(council: council)
  parent :prefecture
end

crumb :assemblyman do |assemblyman|
  if params[:assemblyman_id]
    assemblyman = Assemblyman.find(params[:assemblyman_id])
  else
    assemblyman = Assemblyman.find(params[:id])
  end
  link assemblyman.name, prefecture_council_assemblyman_path(assemblyman: assemblyman)
  parent :council
end

crumb :edit do
  if params[:assemblyman_id]
    assemblyman = Assemblyman.find(params[:assemblyman_id])
  else
    assemblyman = Assemblyman.find(params[:id])
  end
  link '編集', edit_prefecture_council_assemblyman_path(assemblyman: assemblyman)
  parent :assemblyman
end

crumb :tag do
  link "タグ", tags_path
  parent :root
end

crumb :show_tag do |tag|
  if controller_name == 'tags'
    tag = Tag.find(params[:id])
    link tag.name, tag_path(params[:id])
  elsif controller_name == 'manifests'
    manifest = Manifest.find(params[:id])
    link manifest.tags[0].name, tag_path(manifest.tags[0].id)
  end
  parent :tag
end

crumb :manifest do |manifest|
  manifest = Manifest.find(params[:id])
  link manifest.title, manifest_path(params[:id])
  parent :show_tag
end

crumb :question do |question|
  question = Question.find(params[:id])
  link question.title, question_path(params[:id])
  parent :show_tag
end

crumb :edit_manifest do
  link '編集', edit_manifest_path(params[:id])
  parent :manifest
end

crumb :edit_question do
  link '編集', edit_question_path(params[:id])
  parent :question
end
