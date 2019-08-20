class Result < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :result_details, dependent: :destroy
end
