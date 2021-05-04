crumb :root do
  link "ホーム", root_path
end

crumb :prefecture do |prefecture|
  prefecture = Prefecture.find_by_id params[:prefecture_id]
  link prefecture.name, prefecture_councils_path(params[:prefecture_id])
  parent :root
end

crumb :council do |council|
  council = Council.find(params[:council_id])
  link council.name, "/prefectures/#{council.prefecture.id}/councils/#{council.id}/assemblymen"
  parent :prefecture
end

crumb :assemblyman do |assemblyman|
  if params[:id]
    assemblyman = Assemblyman.find(params[:id])
    link assemblyman.name, "/prefectures/#{assemblyman.council.prefecture.id}/councils/#{assemblyman.council.id}/assemblymen/#{assemblyman.id}"
  elsif params[:assemblyman_id]
    assemblyman = Assemblyman.find(params[:assemblyman_id])
    link assemblyman.name, "/prefectures/#{assemblyman.council.prefecture.id}/councils/#{assemblyman.council.id}/assemblymen/#{assemblyman.id}"
  end
  parent :council
end

crumb :edit do
  link '編集', "/prefectures/#{params[:prefecture_id]}/councils/#{params[:council_id]}/assemblymen/#{params[:assemblyman_id]}/edit"
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

crumb :edit_manifest do
  link '編集', edit_manifest_path(params[:id])
  parent :manifest
end
