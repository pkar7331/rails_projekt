class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :show]
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.where(:active_boolean => 1).
                        where('ends_at > ?', DateTime.now).
                        paginate(page: params[:page], per_page: 10)
    #@auctions = Auction.where(:active_boolean => true).
    #                    where("ends_at > ?", DateTime.now).
    #                    paginate(page: params[:page], per_page: 10)
    @search = params["search"]
    if @search.present?
      @title = @search["title"]
      @auctions = Auction.where("title LIKE ?", "%#{@title}%").
                          where(:active_boolean => 1).where('ends_at > ?', DateTime.now).
                          paginate(page: params[:page], per_page: 10)
    end

  #  if user_signed_in?
  #    @auctions = Auction.where.not(:user_id => current_user.id) . paginate(page: params[:page], per_page: 5)
  #  else 
  #    @auctions = Auction.all.paginate(page: params[:page], per_page: 5)
  #  end
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
    @tickets = Ticket.where(:auction_id => @auction.id).order('amount DESC')
  end

  # GET /auctions/new
  def new
    @auction = Auction.new

  end

  # GET /auctions/1/edit
  def edit
    if !current_user.admin?
      redirect_to @auction
    end
  #  if !current_user.try(:admin?) 
   #   redirect_to auctions_path
   # end
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)
    @auction.user_id = current_user.id
    @auction.active_boolean = true
    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    @auction.ends_at = DateTime.now
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    if current_user.admin?
      @auction.destroy
      respond_to do |format|
        format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:description, :price, :title, :ends_at)
    end

    def set_user
      @user = User.where(:id => @auction.user_id)
    end
end
