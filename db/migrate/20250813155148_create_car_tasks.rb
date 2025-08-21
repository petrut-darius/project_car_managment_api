class CreateCarTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :car_tasks do |t|
      t.datetime :get_done_till, null: false
      t.text :content, null: false, default: ""
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
