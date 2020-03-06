class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :exercise_details, dependent: :destroy
  has_many :questions, through: :exercise_details, dependent: :destroy

  scope :last_exercises, -> {order created_at: :desc}
  scope :search_exercises, -> (course_name){joins(:course)
    .where("courses.name LIKE ?", "%#{course_name}%")}
  delegate :name, to: :course, prefix: true
  accepts_nested_attributes_for :exercise_details, allow_destroy: true
  EXERCISE_PARAMS = [:course_id, :user_id,
    exercise_details_attributes: %i(id answer_id question_id exercise_id).freeze]
end
