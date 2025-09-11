class AddRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :string
    add_column :users, :creator_type, :string
    add_column :users, :started_at, :date
  end
end
