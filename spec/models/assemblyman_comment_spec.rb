require 'rails_helper'

RSpec.describe AssemblymanComment, type: :model do
  before do
    @user = create(:user)
    @council = create(:council)
    @assemblyman = create(:assemblyman, council: @council)
    @comment = build(:assemblyman_comment, user: @user, assemblyman: @assemblyman)
  end

  describe 'コメントが投稿できるとき' do
    it 'コメントが正しく入力されていれば投稿できる' do
      expect(@comment).to be_valid
    end
  end

  describe 'コメントが投稿できないとき' do
    it 'コメントが2文字以下だと投稿できない' do
      @comment.content = 'ab'
      @comment.valid?
      expect(@comment.errors.full_messages).to include('コメントは3文字以上で入力してください')
    end
    it 'コメントが257文字以上だと投稿できない' do
      @comment.content = Faker::Lorem.paragraph_by_chars(number: 257, supplemental: false)
      @comment.valid?
      expect(@comment.errors.full_messages).to include('コメントは256文字以内で入力してください')
    end
  end
end
