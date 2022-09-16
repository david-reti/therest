class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.integer :permission_type, default: 0
    end
    add_index :permissions, :permission_type, unique: true
  end
end
