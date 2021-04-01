require 'rails_helper'

RSpec.describe 'manifests', type: :system do
  before do
    @user = create(:user)
    prefecture = create(:prefecture)
    prefectures = create_list(:prefecture, 46)
    council = create(:council, prefecture_id: prefecture.id)
    assemblyman = create(:assemblyman, council_id: council.id)
  end

  context 'マニュフェストを投稿できるとき' do
    it '正しい情報を入力すればマニュフェストが投稿でき、トップページに移動する' do
      # トップページへ移動
      visit root_path
      # マニフェスト投稿ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('投稿する')
      click_on '投稿する'
      # ログインを要求されるのでユーザー情報を入力しログイン
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on 'ログイン'
      # マニュフェスト投稿ページに遷移したことを確認する
      expect(current_path).to eq(new_manifest_path)
      # データをフォームに入力し、投稿するをクリックする
      @manifest = build(:manifest)
      @tag = build(:tag)
      fill_in 'title', with: @manifest.title
      fill_in 'description', with: @manifest.description
      fill_in 'tag-name', with: @tag.name
      click_on '投稿する'
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに投稿したマニュフェストが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@manifest.title)
      expect(page).to have_content(@tag.name)
    end
  end

  context 'マニュフェストを投稿できないとき' do
    it 'データを入力しなければマニュフェストを登録できず、投稿ページがレンダリングされ、エラーメッセージが出力される' do
      # トップページへ移動
      visit root_path
      # マニフェスト投稿ページへ遷移するリンクがあることを確認しクリックする
      expect(page).to have_content('投稿する')
      click_on '投稿する'
      # ログインを要求されるのでユーザー情報を入力しログイン
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on 'ログイン'
      # マニュフェスト投稿ページに遷移したことを確認する
      expect(current_path).to eq(new_manifest_path)
      # フォームが空欄のまま、投稿するをクリックする
      fill_in 'title', with: ''
      fill_in 'description', with: ''
      fill_in 'tag-name', with: ''
      click_on '投稿する'
      # 投稿ページがレンダリングされエラーメッセージが出力されていることを確認する
      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('説明文を入力してください')
      expect(page).to have_content('タグを入力してください')
    end
  end

  context 'マニュフェストを編集できるとき' do
    it '投稿したユーザーは詳細ページから遷移し、マニュフェストを編集できる' do
      @manifest = create(:manifest, user_id: @user.id)
      @tag = create(:tag)
      # トップページへ移動
      visit root_path
      # ログインページへ遷移
      click_on 'ログイン'
      # ユーザー情報を入力しログイン
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on 'ログイン'
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      # 詳細ページへ遷移する
      visit manifest_path(@manifest.id)
      # 編集ボタンが存在することを確認し、クリック
      expect(page).to have_content('編集')
      click_on '編集'
      # 編集ページに遷移したことを確認
      expect(current_path).to eq("/manifests/#{@manifest.id}/edit")
      # 編集後のデータをフォームに入力し、編集ボタンをクリック
      @edited_manifest = build(:manifest, user_id: @user.id)
      @edited_tag = build(:tag)
      fill_in 'title', with: @edited_manifest.title
      fill_in 'description', with: @edited_manifest.description
      fill_in 'tag-name', with: @tag.name
      click_on '編集する'
      # 詳細ページに遷移したことを確認
      expect(current_path).to eq(manifest_path(@manifest.id))
      # 編集後のデータが表示されていることを確認
      expect(page).to have_content(@edited_manifest.title)
      expect(page).to have_content(@edited_manifest.description)
      # トップページに遷移
      visit root_path
      # 編集後のデータが表示されていることを確認
      expect(page).to have_content(@edited_manifest.title)
    end
  end
  
  context 'マニュフェストを編集できないとき' do
    it '投稿ユーザー以外には編集ページへのリンクが表示されず、編集できない' do
      @manifest = create(:manifest, user_id: @user.id)
      @tag = create(:tag)
      # トップページへ移動
      visit root_path
      # ログインページへ遷移
      click_on 'ログイン'
      # 投稿者以外のユーザー情報を入力しログイン
      @another_user = create(:user)
      fill_in 'email', with: @another_user.email
      fill_in 'password', with: @another_user.password
      click_on 'ログイン'
      # ログインに成功し、トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 編集ボタンが存在しないことを確認する
      expect(page).to have_no_content('編集')
    end
    it '投稿ユーザー以外が編集ページにアクセスするとトップページに遷移され、編集できない' do
      @manifest = create(:manifest, user_id: @user.id)
      @tag = create(:tag)
      # トップページへ移動
      visit root_path
      # ログインページへ遷移
      click_on 'ログイン'
      # 投稿者以外のユーザー情報を入力しログイン
      @another_user = create(:user)
      fill_in 'email', with: @another_user.email
      fill_in 'password', with: @another_user.password
      click_on 'ログイン'
      # ログインに成功し、トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
    # 編集ページに遷移
    visit edit_manifest_path(@manifest.id)
    # アクセスできずトップページに遷移することを確認
    expect(current_path).to eq root_path
    end
  end
  
  context 'マニュフェストを削除できるとき' do
    it '投稿したユーザーは詳細ページから遷移し、マニュフェストを削除できる' do
      @manifest = create(:manifest, user_id: @user.id)
      @tag = create(:tag)
      # トップページへ移動
      visit root_path
      # ログインページへ遷移
      click_on 'ログイン'
      # ユーザー情報を入力しログイン
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on 'ログイン'
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 削除ボタンが存在することを確認
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が１減ることを確認
      expect{
        click_on '削除'
      }.to change { Manifest.count }.by(-1)
      # 削除したデータがトップページで表示されていないことを確認
      visit root_path
      expect(page).to have_no_content(@manifest.title)
      expect(page).to have_no_content(@manifest.tags.name)
    end
  end

  context 'マニュフェストを削除できないとき' do
    it '投稿ユーザー以外には削除ページへのリンクが表示されず、削除できない' do
      @manifest = create(:manifest, user_id: @user.id)
      @tag = create(:tag)
      # トップページへ移動
      visit root_path
      # ログインページへ遷移
      click_on 'ログイン'
      # 投稿者以外のユーザー情報を入力しログイン
      @another_user = create(:user)
      fill_in 'email', with: @another_user.email
      fill_in 'password', with: @another_user.password
      click_on 'ログイン'
      # ログインに成功し、トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      # 詳細ページへ遷移する
      click_link 'manifest-link'
      # 削除ボタンが存在しないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end
