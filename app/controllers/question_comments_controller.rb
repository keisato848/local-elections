class QuestionCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :new

  def new
    @comment = QuestionComment.new
  end

  def create
    @comment = QuestionComment.new(comment_params)
    if @comment.save
      redirect_to question_path(params[:question_id]), notice: 'コメントを投稿しました'
    else
      set_question
      render :new
    end
  end

  def destroy
    comment = QuestionComment.find(params[:id])
    if current_user.id == comment.user.id
      comment.destroy!
      redirect_to question_path(params[:question_id]), notice: 'コメントを削除しました'
    else
      redirect_to root_path
    end
  end

  private

  def set_question
    @question = Question.find_by(id: params[:question_id])
  end

  def comment_params
    params.require(:question_comment).permit(:content).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
