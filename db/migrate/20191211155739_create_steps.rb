class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.references :task
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
