class BoardsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_board, only: [:update, :destroy, :visible_all, :visible_active, :visible_complete]

  def index
    @new_board = Board.new
    @board = current_board

    @boards = current_user.boards.includes(:lists)
    @new_list = @board.lists.build
  end

  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      session[:board_id] = @board.id.to_s
      redirect_to boards_path
    else
      render :back
    end
  end

  def update

    if @board.update(board_params)
      redirect_to boards_path
    else
      render :back
    end


  end

  def destroy
    @board.destroy
    redirect_to boards_path
  end

  def change
    session[:board_id] = params[:id]
    redirect_to boards_path
  end

  def visible_all
    @board.update_columns(visible: "All")
    redirect_to boards_path
  end

  def visible_active
    @board.update_columns(visible: "Active")
    redirect_to boards_path
  end

  def visible_complete
    @board.update_columns(visible: "Complete")
    redirect_to boards_path
  end


  private

  def board_params
    params.require(:board).permit(:title, :visible, list_attributes: [:content, :done])
  end

  def find_board
    @board = Board.find(params[:id])
  end



end
