class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:new, :edit, :show]
	before_action :set_user
	before_action :set_own_auctions

	def index	
		
	end

	def show
	end

		private 
		def set_user
			@user = User.find(params[:id])
		end

		def set_own_auctions
			@own_auctions = Auction.where(:user_id => @user.id)
		end

		def set_bid_auctions
			@tickets = Ticket.where(:user_id => current_user.id)
			@bid_auctions = Auction.where(:id => @tickets.auction_id)
		end

end
