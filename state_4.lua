function enter_state_4(conf)
  game_state = 4
end

function leave_state_4()

end

function check_closing_prize(game_state)
  if game_state == 4 then
    return true
  else
    return false
  end
end