require 'rails_helper'

RSpec.describe 'コメント投稿機能', type: :system do
  before do
    @user = create(:user)
    prefectures = create_list(:prefecture, 46)
    @prefecture = prefectures[0]
    @council = create(:council, prefecture: @prefecture)
    @assemblyman = create(:assemblyman, council: @council)
    @comment = build(:assemblyman_comment, assemblyman: @assemblyman, user: @user)
  end

  context 'コメントを投稿できるとき' do
    it '正しい情報を入力すればコメントを投稿できる' do
      # ログイン
      sign_in(@user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # コメント作成ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('コメントを書く')
      click_on('コメントを書く')
      # コメント作成ページに遷移したことを確認する
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}/assemblyman_comments/new")
      # コメントをフォームに入力
      fill_in 'assemblyman_comment[content]', with: @comment.content
      # 送信ボタンをクリックするとコメントが投稿されることを確認する
      expect do
        click_on('送信する')
      end.to change(AssemblymanComment, :count).by(+1)
      # 議員詳細ページに遷移したことを確認する
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # コメントが表示されていることを確認する
      expect(page).to have_content(@comment.content)
      expect(page).to have_content(@comment.user.nickname)
      expect(page).to have_content('削除')
    end
  end

  context 'コメントを投稿できないとき' do
    it '誤った情報ではコメントを投稿できない' do
      @invalid_comment = ''
      # ログイン
      sign_in(@user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # コメント作成ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('コメントを書く')
      click_on('コメントを書く')
      # コメント作成ページに遷移したことを確認する
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}/assemblyman_comments/new")
      # コメントをフォームに入力
      fill_in 'assemblyman_comment[content]', with: @invalid_comment
      # 送信ボタンを押してもコメントが登録されていないことを確認する
      expect do
        click_on('送信する')
      end.to change(AssemblymanComment, :count).by(0)
      # コメント作成ページをレンダリングしたことを確認する
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}/assemblyman_comments")
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('コメントを入力してください')
      expect(page).to have_content('コメントは3文字以上で入力してください')
    end
  end

  context 'コメントを削除できるとき' do
    it '投稿したユーザーは議員詳細ページの削除ボタンを押すことでコメントを削除できる' do
      @comment.save
      # ログイン
      sign_in(@user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # 削除ボタンが表示されていることを確認する
      expect(page).to have_content('削除')
      # コメントが削除されたことを確認する
      expect do
        click_on('削除')
      end.to change(AssemblymanComment, :count).by(-1)
      # 議員詳細ページコメントが表示されていないことを確認
      expect(current_path).to eq("/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}")
      expect(page).to have_no_content(@comment.content)
    end
  end

  context 'コメントを削除できないとき' do
    it '投稿者以外のユーザーには削除ボタンが表示されない' do
      @comment.save
      @another_user = create(:user)
      # ログイン
      sign_in(@another_user)
      # 議員詳細ページへ移動
      visit "/prefectures/#{@prefecture.id}/councils/#{@council.id}/assemblymen/#{@assemblyman.id}"
      # コメントが表示されていることを確認する
      expect(page).to have_content(@comment.user.nickname)
      expect(page).to have_content(@comment.content)
      # 削除ボタンが表示されていないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end
