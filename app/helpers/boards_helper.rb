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

  def visible_selected_class(visible_type)
    if current_board.visible == visible_type
      "btn btn-primary"
    else
      "btn btn-default"
    end
  end

end
