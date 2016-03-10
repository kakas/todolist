class ListsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_board, only: [:create, :update, :destroy, :done_toggle]
  before_action :find_list, only: [:update, :destroy, :done_toggle]

  def create
    @list = @board.lists.build(list_params)

    if @list.save
      redirect_to boards_path
    else
      render :back
    end
  end

  def update
    if @list.update(list_params)
      redirect_to boards_path
    else
      render :back
    end
  end

  def destroy
    @list.destroy

    redirect_to boards_path
  end

  def done_toggle
    @list.toggle!(:done)

    redirect_to boards_path
  end

  private

  def list_params
    params.require(:list).permit(:content, :done)
  end

  def find_board
    @board = Board.find(params[:board_id])
  end

  def find_list
    @list = @board.lists.find(params[:id])
  end

end
