class Course < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_mnay :results, dependent: :destroy
  belongs_to :user
end
