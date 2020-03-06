class Question < ApplicationRecord
  belongs_to :course
  has_many :answers, dependent: :destroy
  validates :question, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true
  QUESTION_PARAMS = [:question, :course_id,
    answers_attributes: %i(id content is_correct _destroy)].freeze
  delegate :name, to: :course, prefix: true, allow_nil: true
  scope :load_question_of_course, ->(course_id){where course_id: course_id}

  class << self
    def import_questions file
      data_questions = []

      CSV.foreach(file.path, headers: true) do |row|
        answers_attributes = JSON.parse(row["answers_attributes"])
        data_questions << {question: row["Question"], course_id: row["Course"],
          answers_attributes: answers_attributes}
      end

      ActiveRecord::Base.transaction do
        Question.create data_questions
      end
    end
  end
end
