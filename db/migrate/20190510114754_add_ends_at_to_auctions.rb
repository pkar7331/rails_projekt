class AddEndsAtToAuctions < ActiveRecord::Migration[5.2]
  def change
    add_column :auctions, :ends_at, :datetime
  end
end
