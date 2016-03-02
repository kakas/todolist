class ListsController < ApplicationController

  def index
    @lists = List.all
    @new_list = List.new
  end

  def new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to lists_path
    else
      render :back
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      redirect_to lists_path
    else
      render :back
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  def done_toggle
    @list = List.find(params[:id])
    @list.toggle!(:done)
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:content, :done)
  end

end
