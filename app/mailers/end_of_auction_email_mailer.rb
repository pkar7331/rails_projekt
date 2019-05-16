class EndOfAuctionEmailMailer < ApplicationMailer
	def notify_user(user,auction)
		@user = user
		@auction = auction
		mail(to: @user.email, subject: "Auction: @auction.title")
	end
end