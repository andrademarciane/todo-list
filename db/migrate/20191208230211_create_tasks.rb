class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :board
      t.string :name

      t.timestamps
    end
  end
end
