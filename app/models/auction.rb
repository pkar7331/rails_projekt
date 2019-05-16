class Auction < ApplicationRecord
	belongs_to :user
	has_many :tickets
	validates :title, :presence => true
	validates :price, :presence => true
	
end
