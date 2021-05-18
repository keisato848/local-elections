class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tag_relations
  has_many :tags, through: :question_tag_relations
  has_many :question_comments, dependent: :destroy
end
