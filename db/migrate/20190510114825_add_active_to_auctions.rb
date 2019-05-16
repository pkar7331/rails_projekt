class AddActiveToAuctions < ActiveRecord::Migration[5.2]
  def change
    add_column :auctions, :active_boolean, :string
  end
end
