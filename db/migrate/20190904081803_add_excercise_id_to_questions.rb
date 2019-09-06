class AddExcerciseIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :excercise_id, :integer
  end
end
