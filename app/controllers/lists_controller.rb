class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update delete destroy ]
  before_action :authenticate_user!
  before_action :get_board
  def index
    #@lists = List.where(board_id: @board.id)
    @lists = @board.lists
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.board_id = @board.id
    if @list.save
      flash[:notice] ="List created successfully......"
      redirect_to board_lists_path(@board)
    else
      render('new')
    end

  end

  def edit
  end

  def update
    if @list.update(list_params)
      flash[:notice] ="List updated successfully......"
      redirect_to board_lists_path(@board)
    else
      render('edit')
    end
  end

  def destroy
    @list.destroy
    redirect_to board_lists_path
    flash[:notice] ="List '#{@list.name}' deleted successfully......"
  end

  private
    def set_list
      @list = List.find(params[:id])
    end
    def get_board
      @board = Board.find(params[:board_id])
    end
    def list_params
      params.required(:list).permit(:name)
    end
end
