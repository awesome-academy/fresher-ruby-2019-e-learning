class Word < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :learnings, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.words.name.max_length}
  validates :pronounce, presence: true,
    length: {maximum: Settings.words.pronounce.max_length}
  validates :meaning, presence: true

  WORD_PARAMS = %i(name pronounce meaning course_id example).freeze

  delegate :name, to: :course, prefix: true, allow_nil: true

  class << self
    def import_word file
     data_words = []

      CSV.foreach(file.path, headers: true) do |row|
        data_words << {name: row["name"], meaning: row["meaning"],
          course_id: row["couse_id"], pronounce: row["pronounce"],
          example: row["example"] }
      end
      
      ActiveRecord::Base.transaction do
        Word.create data_words
      end
    end
  end
end
