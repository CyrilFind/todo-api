class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :description
      t.boolean :done, default: false
      t.datetime :due_date

      t.timestamps
    end
  end
end
