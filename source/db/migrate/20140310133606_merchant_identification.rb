class MerchantIdentification < ActiveRecord::Migration
  def change
    add_column :merchants, :cid, :integer, null: false, default: -1

    add_index :merchants, :cid
  end
end
