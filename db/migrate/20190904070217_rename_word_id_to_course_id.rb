class RenameWordIdToCourseId < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :word_id, :course_id
  end
end
