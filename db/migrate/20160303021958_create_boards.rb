class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :title
      t.string :visible, default: "All"

      t.timestamps null: false
    end
  end
end
