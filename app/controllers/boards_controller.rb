class BoardsController < ApplicationController

  before_action :authenticate_user!

  def index
    @new_board = Board.new
    @boards = current_user.boards.includes(:lists)
    @board = Board.find(session[:board_id].to_i)
    @new_list = @board.lists.build
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
    params.require(:board).permit(:title, :visible, list_attributes: [:content, :done])
  end



end
