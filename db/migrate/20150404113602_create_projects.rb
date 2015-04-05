class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: ''
      t.belongs_to :user, index: true
      t.timestamps null: false
    end

    add_index :projects, :title, unique: true
  end
end
