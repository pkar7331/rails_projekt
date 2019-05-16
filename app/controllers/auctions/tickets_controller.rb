class Auctions::TicketsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_auction
  before_action :go_back, only: [:new, :create]
  before_action :set_top_ticket

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @auction = Auction.find(params[:auction_id])
    @ticket.user_id = current_user.id
    @ticket.auction_id = @auction.id
    if @auction.ends_at > DateTime.now
      if @top_ticket == nil
        if @ticket.amount < @auction.price
          redirect_to request.referrer, notice: 'Minimalna kwota jest większa'
        else
          respond_to do |format|
            if @ticket.save
              format.html { redirect_to auction_url(@ticket.auction_id), notice: 'Ticket was successfully created.' }
              format.json { render :show, status: :created, location: @ticket }
            else
              format.html { render :new }
              format.json { render json: @ticket.errors, status: :unprocessable_entity }
            end
          end  
        end
      else
        if @ticket.amount <= @top_ticket.amount
           redirect_to request.referrer, notice: 'Ticket was unsuccessfully created.'
        else
          respond_to do |format|
            if @ticket.save
              format.html { redirect_to auction_url(@ticket.auction_id), notice: 'Ticket was successfully created.' }
              format.json { render :show, status: :created, location: @ticket }
            else
              format.html { render :new }
              format.json { render json: @ticket.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    else
      redirect_to request.referrer, notice: 'Time left for bidding is over'
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to auction_url(@ticket.auction_id), notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_auction
      @auction = Auction.find(params[:auction_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:amount)
    end

    def go_back
      if @auction.user_id == current_user.id
        respond_to do |format|
          format.html { redirect_to @auction, notice: 'Cant bid your own auction.' }
        end
      end
    end

    def set_top_ticket
      @top_ticket = Ticket.where(:auction_id => @auction.id).order('amount DESC').first
    end

end
