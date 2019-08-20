class CreateResultDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :result_details do |t|
      t.integer :answer_id
      t.integer :questioin_id
      t.integer :result_id

      t.timestamps
    end
  end
end
