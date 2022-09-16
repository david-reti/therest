class CreatePermissionsRolesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :permissions, :roles
  end
end
