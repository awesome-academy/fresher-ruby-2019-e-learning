class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :name
      t.string :meaning
      t.integer :course_id
      t.string :pronounce
      t.string :example

      t.timestamps
    end
  end
end
