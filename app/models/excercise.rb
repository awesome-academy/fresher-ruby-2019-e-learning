class Excercise < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :excercise_details, dependent: :destroy
  accepts_nested_attributes_for :excercise_details, allow_destroy: true
  EXCERCISE_PARAMS = %i(user_id course_id).freeze
  delegate :name, to: :course, prefix: true
end
