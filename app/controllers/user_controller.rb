class UserController < ApplicationController
before_action :find_user


private
	def find_user
		@user = User.find(params[:id])
	end
end
