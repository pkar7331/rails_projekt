class Auction < ApplicationRecord
	belongs_to :user
	has_many :tickets
	validates :title, :presence => true
	validates :price, :presence => true
	validates_length_of :title, maximum: 20, minimum: 2
	
end
