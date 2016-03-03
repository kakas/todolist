class BoardsController < ApplicationController

  def index
    @boards = Boards.all
  end

end
