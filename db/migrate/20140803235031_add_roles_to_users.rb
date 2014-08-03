class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :string, default: ["developer"]
    # string is limited to 255 characters, so don't go too crazy

    # we want to use this field like an ENUM, but Rails does not support this data type
    # postgres has support for array, which comes close, so you could do this:
    #   add_column :users, :roles, array: true, default: []
    #   add_index  :users, :roles, using: 'gin'
    # don't forget the index, otherwise it out be slow!
    # You could use the field like this:
    #   user.update_attributes(roles: ["admin","po"])
    #   User.where("'po' = ANY (roles)")
    # And we would not have to work with the serialize helper
  end
end
