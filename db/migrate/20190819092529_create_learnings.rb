class CreateLearnings < ActiveRecord::Migration[5.2]
  def change
    create_table :learnings do |t|
      t.integer :user_id
      t.integer :word_id

      t.timestamps
    end
  end
end
