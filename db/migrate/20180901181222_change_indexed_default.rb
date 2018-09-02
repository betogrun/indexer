class ChangeIndexedDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:websites, :indexed, false)
  end
end
