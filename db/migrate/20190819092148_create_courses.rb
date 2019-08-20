class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :image
      t.integer :user_id
      t.string :description

      t.timestamps
    end
  end
end
