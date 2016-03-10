module BoardsHelper

  def nav_tab_active_or_not(board)
    if board == current_board
      "active"
    end
  end

  def visible?(list)
    board = current_board
    board.visible == "All" || (board.visible == "Active" && !list.done) || (board.visible == "Complete" && list.done)
  end

end
