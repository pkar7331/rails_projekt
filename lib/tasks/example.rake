task :whatever => :environment do
	auctions = Auction.where(:active_boolean => true).where("ends_at <= ?", DateTime.now)
    auctions.each do |auction|
    	ticket = Ticket.where(:id => auction.id).order('amount DESC').first
    	id = ticket.user_id
    	user = User.where(:id => id).first
    	EndOfAuctionEmailMailer.notify_user(user,auction).deliver
    end
    auctions.update_all(:active_boolean => false)
end
