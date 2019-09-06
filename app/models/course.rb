class Course < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :words, dependent: :destroy
  has_many :excercises, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :image

  delegate :name, to: :user, prefix: true, allow_nil: true

  COURSE_PARAMS = %i(name user_id image description).freeze

  scope :with_users, ->{Excercise.includes(:course).group(:course_id).count(:user_id)}
end
