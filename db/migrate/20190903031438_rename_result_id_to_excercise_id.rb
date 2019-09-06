class RenameResultIdToExcerciseId < ActiveRecord::Migration[5.2]
  def change
    rename_column :excercise_details, :result_id, :excercise_id
  end
end
