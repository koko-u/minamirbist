class AddUidAndProviderToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :uid, :string
    add_column :members, :provider, :string
  end

  def self.down
    remove_column :members, :provider
    remove_column :members, :uid
  end
end
