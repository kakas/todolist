class ListsController < ApplicationController

  before_action :authenticate_user!

  def create
    @board = Board.find(params[:board_id])
    @list = @board.lists.build(list_params)

    if @list.save
      redirect_to boards_path
    else
      render :back
    end
  end

  def update
    @board = Board.find(params[:board_id])
    @list = @board.lists.find(params[:id])

    if @list.update(list_params)
      redirect_to boards_path
    else
      render :back
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @list = @board.lists.find(params[:id])
    @list.destroy

    redirect_to boards_path
  end

  def done_toggle
    @board = Board.find(params[:board_id])
    @list = @board.lists.find(params[:id])
    @list.toggle!(:done)

    redirect_to boards_path
  end

  private

  def list_params
    params.require(:list).permit(:content, :done)
  end

end
