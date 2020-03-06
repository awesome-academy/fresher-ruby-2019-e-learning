class Course < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :destroy
  has_many :exercises, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :image

  delegate :name, to: :user, prefix: true, allow_nil: true
  scope :sort_by_created_at, ->{order(created_at: :desc)}
  scope :with_user, ->(course_id){includes(:user).where(course_id: cuorse_id).count(:user_id)}
  COURSE_PARAMS = %i(name user_id image description).freeze
end
