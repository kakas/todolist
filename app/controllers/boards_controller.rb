class BoardsController < ApplicationController

  before_action :authenticate_user!

  def index
    @boards = current_user.boards.includes(:lists)
    @new_board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      redirect_to boards_path
    else
      render :back
    end
  end

  def change
    session[:board_id] = params[:id]
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title, :visible)
  end



end
