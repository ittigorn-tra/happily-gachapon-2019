function calc_debug_pos(x, y)
  x = (game_area.pos.x.start+(x*game_area.ratio))
  y = (game_area.pos.y.start+(y*game_area.ratio))
  return x, y
end

function draw_debug_section(game_area, conf)
  if conf.show_debug_messages then
    love.graphics.setNewFont(12)
    love.graphics.setColor(1.0, 1.0, 1.0, 0.8)
    love.graphics.rectangle('fill', game_area.pos.x.start, game_area.pos.y.start, game_area.dim.w, 250)
    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
    love.graphics.print('Game State: ' ..game_state, calc_debug_pos(20, 20))
    love.graphics.print('Button State: ' ..button_state, calc_debug_pos(20, 50))
    love.graphics.print('State 1 timer: ' ..state_1_timer, calc_debug_pos(20, 80))
    -- love.graphics.print('Since Last Pressed: ' ..since_last_pressed, 50, 90)
    -- love.graphics.print('Pong kicked: ' ..(pong_kicked and 'true' or 'false'), 50, 110)
    -- love.graphics.print('Current dt: ' ..current_dt, 50, 130)
    -- love.graphics.print('State 1 Timer: ' ..state_1_timer, 50, 150)
    -- local x, y = pong.body:getLinearVelocity()
    -- love.graphics.print('Pong Velocity X: ' ..x, 50, 170)
    -- love.graphics.print('Pong Velocity Y: ' ..y, 50, 190)

    -- love.graphics.print('Qty Blue: ' ..prizes.blue.qty, 350, 50)
    -- love.graphics.print('Qty Red: ' ..prizes.red.qty, 350, 70)
    -- love.graphics.print('Qty Green: ' ..prizes.green.qty, 350, 90)
    -- love.graphics.print('Qty Metallic: ' ..prizes.metallic.qty, 350, 110)
    -- love.graphics.print('Qty Gold: ' ..prizes.gold.qty, 350, 130)
    -- love.graphics.print('Qty Purple: ' ..prizes.purple.qty, 350, 150)

    -- love.graphics.print('Range Blue: ' ..prize_chance_map.blue.min ..' - ' ..prize_chance_map.blue.max , 550, 50)
    -- love.graphics.print('Range Red: ' ..prize_chance_map.red.min ..' - ' ..prize_chance_map.red.max , 550, 70)
    -- love.graphics.print('Range Green: ' ..prize_chance_map.green.min ..' - ' ..prize_chance_map.green.max , 550, 90)
    -- love.graphics.print('Range Metallic: ' ..prize_chance_map.metallic.min ..' - ' ..prize_chance_map.metallic.max , 550, 110)
    -- love.graphics.print('Range Gold: ' ..prize_chance_map.gold.min ..' - ' ..prize_chance_map.gold.max , 550, 130)
    -- love.graphics.print('Range Purple: ' ..prize_chance_map.purple.min ..' - ' ..prize_chance_map.purple.max , 550, 150)
    -- love.graphics.print('Rand X: ' ..rand_x, 550, 170)
    -- love.graphics.print('Listening to state 20 clicks: ' ..(listening_to_state_20_clicks and 'true' or 'false'), 550, 190)
    -- love.graphics.print('State 20 click count: ' ..state_20_click_count, 550, 210)
    -- love.graphics.print('State 20 timer: ' ..state_20_timer, 550, 230)
  end
end