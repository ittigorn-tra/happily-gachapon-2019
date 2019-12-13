state_1_timer             = 0

function update_state_1(dt, game_state, conf)
  if game_state == 1 then
    if state_1_timer < conf.state_1_pause_duration then
      state_1_timer = state_1_timer + dt
    end
  end
end

function check_if_in_state_1_pause_duration(conf)
  return state_1_timer >= conf.state_1_pause_duration
end

function enter_state_1()
  game_state = 1
end

function leave_state_1()
  button_pressed = false
  state_1_timer = 0
end