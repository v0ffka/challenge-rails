class OfferIdentification < ActiveRecord::Migration
  def change
    add_column :offers, :link_id, :integer, :null => false, :default => -1

    add_index :offers, :link_id
  end
end
