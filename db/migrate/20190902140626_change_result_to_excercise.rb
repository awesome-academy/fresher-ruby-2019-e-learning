class ChangeResultToExcercise < ActiveRecord::Migration[5.2]
  def change
    rename_table :results, :excercises
  end
end
