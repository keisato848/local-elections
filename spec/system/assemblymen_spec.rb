require 'rails_helper'

RSpec.describe '議員情報編集', type: :system do
  before do
    @user = create(:user)
    @prefecture = create(:prefecture)
    prefectures = create_list(:prefecture, 46)
    @council = create(:council, prefecture_id: @prefecture.id)
    @assemblyman = create(:assemblyman, council_id: @council.id)
  end

  context '議員情報を編集できるとき' do
    it '正しい情報を入力すれば議員情報を編集でき、議員詳細画面に移動する' do
      # ログイン
      sign_in(@user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # 議員情報編集ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('編集')
      click_on('編集')
      # 議員情報編集ページに遷移したことを確認する
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}/edit")
      # 編集後のデータをフォームに入力し、編集をクリックする
      @edited_assemblyman = build(:assemblyman, council_id: @council.id)
      fill_in 'name', with: @edited_assemblyman.name
      fill_in 'sex', with: @edited_assemblyman.sex
      fill_in 'birth_of_date', with: @edited_assemblyman.birth_of_date
      fill_in 'position', with: @edited_assemblyman.position
      fill_in 'faction', with: @edited_assemblyman.faction
      fill_in 'number_of_wins', with: @edited_assemblyman.number_of_wins
      fill_in 'job', with: @edited_assemblyman.job
      fill_in 'img_url', with: @edited_assemblyman.img_url
      fill_in 'twitter_url', with: @edited_assemblyman.twitter_url
      click_on('編集する')
      # 議員詳細ページに遷移したことを確認する
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # 編集内容が反映されていることを確認する
      expect(page).to have_content(@edited_assemblyman.name)
      expect(page).to have_content(@edited_assemblyman.position)
      expect(page).to have_content(@edited_assemblyman.faction)
      expect(page).to have_content(@edited_assemblyman.number_of_wins)
      expect(page).to have_content(@edited_assemblyman.job)
    end
  end

  context '議員情報を編集できないとき' do
    it '誤った情報では議員情報を編集できず、レンダリングされ、エラーメッセージが出力される' do
      # ログイン
      sign_in(@user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # 議員情報編集ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('編集')
      click_on('編集')
      # 議員情報編集ページに遷移したことを確認する
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}/edit")
      # 編集後のデータをフォームに入力し編集をクリックする
      fill_in 'name', with: ''
      fill_in 'sex', with: '123'
      fill_in 'birth_of_date', with: 'hoge'
      fill_in 'number_of_wins', with: 'hoge'
      fill_in 'img_url', with: 'hoge'
      fill_in 'twitter_url', with: '@abcde0123456789'
      click_on('編集する')
      # 議員編集ページがレンダリングされたことを確認する
      expect(current_path).to eq("/prefectures/#{@assemblyman.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}")
      # エラーメッセージが出力されていることを確認する
      expect(page).to have_content('氏名を入力してください')
      expect(page).to have_content('性別は全角文字で入してください')
      expect(page).to have_content('当選回数は数値で入力してください')
      expect(page).to have_content('アカウント名は＠を含まずに15文字以内で入力してください（半角英数、アンダーバーのみ利用可）')
      expect(page).to have_content('画像URLは無効な値です')
    end
  end
end
