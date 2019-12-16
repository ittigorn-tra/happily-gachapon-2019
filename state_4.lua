function enter_state_4(conf)
  game_state = 4
  play_prize_sound(prizes[prize_key].sound)
end

function leave_state_4()
  stop_prize_sound(prizes[prize_key].sound)
  play_pressing_sound()
end

function check_closing_prize(game_state)
  if game_state == 4 then
    return true
  else
    return false
  end
end