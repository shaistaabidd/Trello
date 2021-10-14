class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!
  def index
    @boards = current_user.boards
  end

  def show
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:notice] ="Board created successfully......"
      redirect_to("/boards")
    else
      render('new')
    end
  end

  def update
    
    if @board.update(board_params)
      flash[:notice] ="Board updated successfully......"
      redirect_to(boards_path(@board))
    else
      render('edit')
    end
  end

  def delete
  end

  def destroy
    @board.destroy
    flash[:notice] ="Board '#{@board.name}' destroyed successfully......"
    redirect_to(boards_path)
  end

  private
  def set_board
    @board = Board.find(params[:id])
  end
  def board_params
    params.required(:board).permit(:name,:user_id)
  end
end
