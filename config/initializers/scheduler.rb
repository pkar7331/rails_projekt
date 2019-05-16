require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1h' do
	auctions = Auction.where(:active_boolean => true).where("ends_at <= ?", DateTime.now)
	auctions.update_all(:active_boolean => false)
	auctions.each do |auction|
		ticket = Ticket.where(:auction_id => auction.id)
		user = User.find(:id => ticket.user_id)
	end
end