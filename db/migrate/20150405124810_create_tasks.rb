class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false, default: ''
      t.boolean :done, default: false
      t.integer :order, default: 65536, null: false
      t.date :deadline
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
