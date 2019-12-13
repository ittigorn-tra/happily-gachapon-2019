state_2_timer = 0

function update_state_2(dt, game_state, conf)
  if game_state == 2 then
    if state_2_timer < conf.state_2_duration then
      state_2_timer = state_2_timer + dt
    else
      leave_state_2()
      enter_state_3(conf)
    end
  end
end

function enter_state_2()
  game_state = 2
end

function leave_state_2()
  state_2_timer = 0
end