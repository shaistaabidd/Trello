class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_list
  def index
    @cards = Card.all
  end

  def show
        
  end

  def new
    @board = Board.find(params[:board_id])
    @card = Card.new
  end

  def create
    @board = Board.find(params[:board_id])
    @card = Card.new(card_params)
    @card.list_id = @list.id
    if @card.save
      #flash[:notice] ="Subject created successfully......"
      redirect_to board_list_cards_path(@card.list.board, @card.list)
    else
      render('new')
    end

  end

  def edit
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end
    def get_list
      @list = List.find(params[:list_id])
    end
    def card_params
      params.required(:card).permit(:name,:status)
    end
end
