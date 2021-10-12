class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @boards = Board.all
  end

  def show
  end

  def new
    #@board = Board.new
    @board = current_user.boards.build
  end

  def edit
  end

  def create
    #@board= Board.new(board_params)
    @board = current_user.boards.build(board_params)
    if @board.save
      #flash[:notice] ="Subject created successfully......"
      redirect_to("/boards")
    else
      render('new')
    end
  end

  def update
    
    if @board.update(board_params)
      #flash[:notice] ="Section updated successfully......"
      redirect_to(board_path(@board))
    else
      render('edit')
    end
  end

  def delete
  end

  def destroy
    #@board = Board.find(params[:id])
    @board.destroy
    #flash[:notice] ="Section '#{@section.name}' delete successfully......"
    redirect_to(boards_path)
  end

  def correct_user
    @board=current_user.boards.find_by(id: params[:id])
    #redirect_to boards_path#, :notice "Not Authorized To Edit this Board" if board.nil?
    redirect_to boards_path if @board.nil?
  end

  private
  def set_board
    @board = Board.find(params[:id])
  end
  def board_params
    params.required(:board).permit(:name,:user_id)
  end
end
