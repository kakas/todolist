module BoardsHelper

  def nav_tab_active_or_not(board)
    if board == current_board
      "active"
    end
  end

end
