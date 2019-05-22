class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :show]
	before_action :set_user
	before_action :set_own_auctions
	before_action :set_bid_auctions
	def index	
		
	end

	def show

	end

		private 
		def set_user
			@user = User.find(params[:id])
		end

		def set_own_auctions
			@own_auctions = Auction.where(:user_id => @user.id).paginate(page: params[:page1], per_page: 5)
		end

		def set_bid_auctions
			@bid_auctions = []
			@tickets = Ticket.where(:user_id => current_user.id)
			@tickets.each do |ticket|
				@bid_auctions += Auction.where(:id => ticket.auction_id)
			end
			@bid_auctions = @bid_auctions.uniq
			@bid_auctions = @bid_auctions.paginate(page: params[:page2], per_page: 5)

		end

end
