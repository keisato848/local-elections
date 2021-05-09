class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy]
  before_action :user_restrictions, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = QuestionTag.new
  end

  def create
    @question = QuestionTag.new(question_params)
    if @question.valid?
      @question.save
      created_question = Question.find_by(title: @question.title)
      redirect_to question_path(created_question), notice: '質問を投稿しました'
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    # コメント用の記述
  end

  def edit
    @question_tag = QuestionTag.new
    @question = Question.find(params[:id])
    @tag_names = Tag.find_tag(@question)
  end

  def update
    @question = QuestionTag.new(question_params)
    if @question.valid?
      @question.update(params[:id])
      redirect_to question_path(params[:id]), notice: '質問を更新しました'
    else
      render :edit
    end
  end

  def destroy
    question = QuestionTag.new
    if question.destroy(params[:id])
      redirect_to root_path, notice: '質問を削除しました'
    else
      render :show
    end
  end

  private

  def question_params
    params.require(:question_tag).permit(:title, :description, :name).merge(user_id: current_user.id)
  end

  def user_restrictions
    question = Question.find(params[:id])
    redirect_to root_path if current_user.id != question.user.id
  end
end
