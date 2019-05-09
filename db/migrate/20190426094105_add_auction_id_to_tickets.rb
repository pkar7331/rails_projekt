class AddAuctionIdToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :auction_id, :integer
  end
end
