require 'rails_helper'

RSpec.describe 'manifest_tag', type: :system do
  before do
    @user = create(:user)
    @manifest_tag = build(:manifest_tag, user_id: @user.id)
  end

  context 'マニュフェストを投稿できるとき' do
    it '正しい情報を入力すればマニュフェストが投稿でき、トップページに移動する' do
      @manifest_tag = build(:manifest_tag, user_id: @user.id)
      # ログイン
      sign_in(@user)
      # マニフェスト投稿ページへ遷移
      visit new_manifest_path
      # マニュフェスト投稿ページに遷移したことを確認
      expect(current_path).to eq(new_manifest_path)
      # データをフォームに入力し、投稿するをクリック
      fill_in 'title', with: @manifest_tag.title
      fill_in 'description', with: @manifest_tag.description
      fill_in 'tag-name', with: @manifest_tag.name
      click_on '投稿する'
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      # トップページに投稿したマニュフェストが表示されていることを確認
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@manifest_tag.title)
      expect(page).to have_content(@manifest_tag.name)
    end
  end

  context 'マニュフェストを投稿できないとき' do
    it 'データを入力しなければマニュフェストを登録できず、投稿ページがレンダリングされ、エラーメッセージが出力される' do
      @manifest_tag = build(:manifest_tag, user_id: @user.id)
      # ログイン
      sign_in(@user)
      # マニフェスト投稿ページへ遷移
      visit new_manifest_path
      # マニュフェスト投稿ページに遷移したことを確認
      expect(current_path).to eq(new_manifest_path)
      # フォームが空欄のまま、投稿するをクリック
      fill_in 'title', with: ''
      fill_in 'description', with: ''
      fill_in 'tag-name', with: ''
      click_on '投稿する'
      # 投稿ページがレンダリングされエラーメッセージが出力されていることを確認
      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('説明文を入力してください')
      expect(page).to have_content('タグを入力してください')
    end
  end

  context 'マニュフェストを編集できるとき' do
    it '投稿したユーザーは詳細ページから遷移し、マニュフェストを編集できる' do
      # マニュフェストを保存
      @manifest_tag.save
      # ログイン
      sign_in(@user)
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 編集ボタンが存在することを確認し、クリック
      expect(page).to have_content('編集')
      click_on '編集'
      # 編集後のデータをフォームに入力し、編集ボタンをクリック
      @edited_manifest_tag = build(:manifest_tag, user_id: @user.id)
      fill_in 'title', with: @edited_manifest_tag.title
      fill_in 'description', with: @edited_manifest_tag.description
      fill_in 'tag-name', with: @edited_manifest_tag.name
      click_on '編集する'
      # 編集後のデータが表示されていることを確認
      expect(page).to have_content(@edited_manifest_tag.title)
      expect(page).to have_content(@edited_manifest_tag.description)
      # トップページに遷移
      visit root_path
      # 編集後のデータが表示されていることを確認
      expect(page).to have_content(@edited_manifest_tag.title)
    end
  end

  context 'マニュフェストを編集できないとき' do
    it '投稿ユーザー以外には編集ページへのリンクが表示されず、編集できない' do
      # マニュフェストを保存
      @manifest_tag.save
      # 投稿者以外のユーザーがログイン
      @another_user = create(:user)
      sign_in(@another_user)
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 編集ボタンが存在しないことを確認する
      expect(page).to have_no_content('編集')
    end
    it '投稿ユーザー以外が編集ページにアクセスするとトップページに遷移され、編集できない' do
      # マニュフェストを保存
      @manifest_tag.save
      # 投稿者以外のユーザーがログイン
      @another_user = create(:user)
      sign_in(@another_user)
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 編集ページに遷移
      visit "#{current_path}/edit"
      # アクセスできずトップページに遷移することを確認
      expect(current_path).to eq root_path
    end
  end

  context 'マニュフェストを削除できるとき' do
    it '投稿したユーザーは詳細ページから遷移し、マニュフェストを削除できる' do
      # マニュフェストを保存
      @manifest_tag.save
      # ログイン
      sign_in(@user)
      # 詳細ページへ遷移
      click_link 'manifest-link'
      # 投稿を削除するとレコードの数が１減ることを確認
      accept_alert do
        click_on '削除'
      end
      expect do
        visit current_path
      end.to change { Manifest.count }.by(-1)
      # 削除したデータがトップページで表示されていないことを確認
      visit root_path
      expect(page).to have_no_content(@manifest_tag.title)
      expect(page).to have_no_content(@manifest_tag.name)
    end
  end

  context 'マニュフェストを削除できないとき' do
    it '投稿ユーザー以外には削除ページへのリンクが表示されず、削除できない' do
      # マニュフェストを保存
      @manifest_tag.save
      # 投稿者以外のユーザーがログイン
      @another_user = create(:user)
      sign_in(@another_user)
      # 詳細ページへ遷移
      click_link 'manifest-link'
      # 削除ボタンが存在しないことを確認
      expect(page).to have_no_content('削除')
    end
  end
end
