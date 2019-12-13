state_1_timer             = 0
since_last_button_pressed = 0
pong_kicked               = false

function update_state_1(dt, game_state, conf)
  if game_state == 1 then
    if state_1_timer < conf.state_1_pause_duration then
      state_1_timer = state_1_timer + dt
    end
  end
end

function check_if_in_state_1_pause_duration()
  return state_1_timer >= conf.state_1_pause_duration
end

function leave_state_1()
  state_1_timer = 0
end

function reset_game_state() -- return to default state
  -- if prizes[prize_key].sound:isPlaying() then prizes[prize_key].sound:stop() end
  -- play_pressing_sound()
  game_state                = 1
  since_last_button_pressed = 0
  pong_kicked               = false
  reset_pong_pos()
end