-- ESC to exit game
-- CLICK on button to play


function set_default_alpha()
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end

function love.load()

  -- SEED RANDOM
  math.randomseed(os.time())

  require('./conf')
  require('./responsiveness')

  -- SET INITIAL VARIABLES
  game_state    = 1
  button_state  = 0
  prize_key     = 'blue'

  -- SET WINDOWS RESOLUTION
  love.window.setTitle( 'Happily Gachapon' )
  love.window.setMode( 0, 0, {fullscreen=conf.fullscreen, fullscreentype = conf.fullscreentype, display=conf.display} )
  conf.screen_width, conf.screen_height = love.graphics.getWidth(), love.graphics.getHeight()
  game_area = calc_game_area(conf.default_width, conf.default_height, conf.default_ratio, conf.screen_width, conf.screen_height)

  -- import other modules
  require('./inventory_management')
  -- require('./barriers')
  -- require('./prizes')
  -- require('./pong')
  require('./graphics')
  require('./button')
  require('./physics')

  -- animations
  require('./animated_graphics')
  require('./pongs_in_window')



end -- end love.load()




function love.update(dt)
  
  current_dt = dt
  world:update(dt) --this puts the world into motion

  button_state = check_button_clicked()

end -- end love.update()




function love.draw()

  -- set solid alpha
  set_default_alpha()

  draw_bg(game_area)                    -- draw bg
  draw_pong_in_window(game_area, conf)  -- pongs in window
  draw_pong(prize_key)                  -- draw pong
  draw_fg(game_area, conf)              -- draw fg
  draw_button(button_state)             -- draw button
  draw_barriers(conf)                   -- draw barriers

  
  

  if show_debug_messages then
    love.graphics.setNewFont(12)
    love.graphics.setColor(1.0, 1.0, 1.0, 0.8)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 250)
    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
    -- love.graphics.print('Game State: ' ..game_state, 50, 50)
    -- love.graphics.print('Button State: ' ..button_state, 50, 70)
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

end -- end love.draw()





--------------- CUSTOM FUNCTIONS --------------



-- Exit on pressing ESC
function love.keypressed(k)
  if k == 'escape' then
    if (game_state == 4) or (game_state == 10) or (game_state == 20) then
      reset_game_state()
    else
      love.event.quit()
    end
  elseif k == 'home' and game_state == 1 then
    enter_state_20()
  end
end