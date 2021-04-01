crumb :root do
  link "ホーム", root_path
end

crumb :tag do
  link "タグ一覧", tags_path
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

crumb :prefecture do |prefecture|
  if controller_name == 'prefectures'
    prefecture = Prefecture.find(params[:id])
    link prefecture.name, prefecture_path(params[:id])
  else
    prefecture = Prefecture.find(params[:prefecture_id])
    link prefecture.name, prefecture_path(params[:prefecture_id])
  end
  parent :root
end

crumb :council do |council|
  if controller_name == 'councils'
    council = Council.find(params[:id])
    link council.name, prefecture_council_path(params[:id])
  else
    council = Council.find(params[:council_id])
    link council.name, "/prefectures/#{params[:prefecture_id]}/councils/#{council.id}"
  end
  parent :prefecture
end

crumb :assemblyman do |assemblyman|
  if controller_name == 'assemblymen'
    assemblyman = Assemblyman.find(params[:id])
    link assemblyman.name, prefecture_council_assemblyman_path(params[:id])
  else
  assemblyman = Assemblyman.find(params[:assemblyman_id])
  link assemblyman.name, "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{assemblyman.id}"
  end
  parent :council
end

crumb :comment do |comment|
  link 'コメント', "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{params[:assemblyman_id]}/edit"
  parent :assemblyman
end

crumb :edit do |edit|
  link '編集', "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{params[:assemblyman_id]}/edit"
  parent :assemblyman
end
