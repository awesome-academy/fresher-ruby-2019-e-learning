class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :results, dependent: :destroy
  has_may :learning, dependent: :destroy
  has_many :active_relationships, class_name: Follower.name,
    foreign_key: "follower_id", dependent: :destroy
  has_mnay :passive_relationships, class_name: Follower.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followed, through: :passive_relationships, source: :follower
end
