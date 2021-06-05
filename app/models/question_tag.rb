class QuestionTag
  include ActiveModel::Model
  attr_accessor :title, :description, :name, :user_id

  with_options presence: true do
    validates :title, uniqueness: true
    validates :description
    validates :name
    validates :user_id
  end

  def save
    question = Question.create(title: title, description: description, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    QuestionTagRelation.create(question_id: question.id, tag_id: tag.id)
  end

  def update(question_id)
    question = Question.find(question_id)
    question.update(title: title, description: description)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    question_tag = QuestionTagRelation.find_by(question_id: question_id)
    question_tag.update(tag_id: tag.id)
  end

  def destroy(question_id)
    question_tag = QuestionTagRelation.find_by(question_id: question_id)
    question_tag.destroy
    question = Question.find(question_id)
    question.destroy
  end
end
