class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
