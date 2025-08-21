class AddUserToCarTask < ActiveRecord::Migration[8.0]
  def change
    add_reference :car_tasks, :user, null: false, foreign_key: true
  end
end
