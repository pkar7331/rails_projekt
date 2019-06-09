class AddActiveToAuctions < ActiveRecord::Migration[5.2]
  def change
    add_column :auctions, :active_boolean, :boolean
  end
end
