class BoardsController < ApplicationController

  before_action :authenticate_user!

  def index
    @new_board = Board.new

    if current_user.boards.first.present?
      @board = Board.find(session[:board_id].to_i)
    else
      @board = @new_board
    end

    @boards = current_user.boards.includes(:lists)
    @new_list = @board.lists.build

    @class_all = "btn btn-default"
    @class_active = "btn btn-default"
    @class_complete = "btn btn-default"

    case @board.visible
    when "All"
      @class_all = "btn btn-primary"
    when "Active"
      @class_active = "btn btn-primary"
    when "Complete"
      @class_complete = "btn btn-primary"
    end

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

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    if Board.first.present?
      session[:board_id] = Board.first.id
    else
      session[:board_id] = "0"
    end

    redirect_to boards_path
  end

  def change
    session[:board_id] = params[:id]
    redirect_to boards_path
  end

  def visible_all
    @board = Board.find(params[:id])
    @board.update_columns(visible: "All")
    @board.save
    redirect_to boards_path
  end

  def visible_active
    @board = Board.find(params[:id])
    @board.update_columns(visible: "Active")
    @board.save
    redirect_to boards_path
  end

  def visible_complete
    @board = Board.find(params[:id])
    @board.update_columns(visible: "Complete")
    @board.save
    redirect_to boards_path
  end


  private

  def board_params
    params.require(:board).permit(:title, :visible, list_attributes: [:content, :done])
  end



end
