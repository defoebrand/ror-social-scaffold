class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :requestor_id
      t.integer :requestee_id
      t.string :status

      t.timestamps
    end
    add_foreign_key :friends, :users, column: :requestor_id
    add_foreign_key :friends, :users, column: :requestee_id
  end
end
