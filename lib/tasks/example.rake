task :whatever => :environment do
	auctions = Auction.where(:active_boolean => true).where("ends_at <= ?", DateTime.now)
	auctions.update_all(:active_boolean => false)
end
