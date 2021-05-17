class QuestionComment < ApplicationRecord
  belongs_to :user
  belongs_to :question

  with_options presence: true do
    validates :user_id
    validates :question_id
    validates :content, length: { minimum: 3, maximum: 256 }
  end
end
