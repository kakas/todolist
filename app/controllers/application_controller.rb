class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_board

  def current_board
    @current_board ||= find_current_board
  end

  private

  def find_current_board
    board = Board.find_by(id: session[:board_id]) || current_user.boards.first

    if board.blank?
        board = current_user.boards.build(title: "Board's name")
        board.save
    end

    session[:board_id] = board.id
    board
  end
end
