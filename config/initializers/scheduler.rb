require 'rufus-scheduler'



s = Rufus::Scheduler.new

s.every '1m' do
	
	auctions = Auction.where(:active_boolean => true).where("ends_at <= ?", DateTime.now)
    auctions.each do |auction|
    	ticket = Ticket.where(:id => auction.id).order('amount DESC').first
    	if ticket.present?
    		user = User.where(:id => ticket.user_id).first
    		EndOfAuctionEmailMailer.notify_user(user,auction).deliver
    	end
    end
    auctions.update_all(:active_boolean => false)

end