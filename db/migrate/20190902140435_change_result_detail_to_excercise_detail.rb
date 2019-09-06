class ChangeResultDetailToExcerciseDetail < ActiveRecord::Migration[5.2]
  def change
    rename_table :result_details, :excercise_details
  end
end
