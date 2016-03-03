class ListsController < ApplicationController

  def index
    @lists = List.all
    @new_list = List.new

    if session[:visible_type].nil?
      session[:visible_type] = "All"
    end

    @visible = session[:visible_type]
    @class_all = "btn btn-default"
    @class_active = "btn btn-default"
    @class_complete = "btn btn-default"

    case @visible
    when "All"
      @class_all = "btn btn-primary"
    when "Active"
      @class_active = "btn btn-primary"
    when "Complete"
      @class_complete = "btn btn-primary"
    end

  end

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

  def visible_all
    session[:visible_type] = "All"
    redirect_to lists_path
  end

  def visible_active
    session[:visible_type] = "Active"
    redirect_to lists_path
  end

  def visible_complete
    session[:visible_type] = "Complete"
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:content, :done)
  end

end
