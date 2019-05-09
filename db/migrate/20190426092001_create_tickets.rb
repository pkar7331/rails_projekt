class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.float :amount

      t.timestamps
    end
  end
end
