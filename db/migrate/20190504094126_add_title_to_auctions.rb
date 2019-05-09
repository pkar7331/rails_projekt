class AddTitleToAuctions < ActiveRecord::Migration[5.2]
  def change
    add_column :auctions, :title, :string
  end
end
