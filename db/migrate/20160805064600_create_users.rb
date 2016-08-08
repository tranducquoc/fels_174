class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.boolean :is_admin

      t.timestamps null: false
    end
    add_column :users, :remember_digest, :string
  end
end
