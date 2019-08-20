class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :status, default: 0
      t.integer :result, default: 0
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
