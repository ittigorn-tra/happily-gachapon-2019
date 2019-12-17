-- ESC to exit game
-- CLICK on button to play

-- states
-- 10 - prize preview mode


function set_default_alpha()
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end

function calc_distance(x1, y1, x2, y2)
  return math.sqrt((y1 - y2)^2 + (x1 - x2)^2)
end

function new_animation(image, width, height, duration, frames)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};

  current_frame = 1
  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      if current_frame <= frames then
          table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
          current_frame = current_frame + 1
      end
    end
  end

  animation.duration = duration or 1
  animation.currentTime = 0

  return animation
end



function love.load()

  -- SEED RANDOM
  math.randomseed(os.time())

  require('./conf')
  require('./responsiveness')

  -- SET INITIAL VARIABLES
  game_state    = 1
  prize_key     = 'blue'

  -- SET WINDOWS RESOLUTION
  love.window.setTitle( 'Happily Gachapon' )
  -- love.window.setMode( 0, 0, {fullscreen=conf.fullscreen, fullscreentype=conf.fullscreentype, display=conf.display} )
  love.window.setMode( 0, 0, {fullscreen=conf.fullscreen, fullscreentype=conf.fullscreentype} )
  conf.screen_width, conf.screen_height = love.graphics.getWidth(), love.graphics.getHeight()
  game_area = calc_game_area(conf.default_width, conf.default_height, conf.default_ratio, conf.screen_width, conf.screen_height)

  -- import modules
  require('./pong')
  require('./inventory_management')
  require('./graphics')
  require('./button')
  require('./barriers')
  require('./prizes')

  require('./physics')
  require('./sounds')

  -- animations
  require('./pongs_in_window')
  require('./prize_preview')

  -- states
  require('./state_1') -- ready state
  require('./state_2') -- shuffling state
  require('./state_3') -- pong dropping state
  require('./state_4') -- pong awaiting click state

  -- dev
  require('./debug')

  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

end -- end love.load()




function love.update(dt)
  
  current_dt = dt
  world:update(dt) --this puts the world into motion
  update_prize_preview_bubble(dt)

  check_button_clicked(game_state, conf, dt)

  update_state_1(dt, game_state, conf)
  update_state_2(dt, game_state, conf)
  update_state_20(dt)

  update_pongs_in_window(game_state, button_state, dt)

  update_stars(dt, game_area, conf)
  -- update_flies(dt, game_area, conf)

  update_music_volume(conf, dt)

end -- end love.update()




function love.draw()

  -- set solid alpha
  set_default_alpha()

  draw_bg(game_area)                    -- draw bg
  draw_pong(prize_key)                  -- draw pong
  draw_pong_in_window(game_area, conf)  -- pongs in window
  draw_fg(game_area, conf)              -- draw fg
  draw_button(button_state)             -- draw button

  draw_prize_preview_bubble(game_area)  -- draw prize preview button
  draw_prize_preview_button(game_area)  -- draw prize preview button
  draw_prize_preview_popup(game_area, game_state)   -- draw prize preview popup

  draw_prize(game_area, game_state, conf) -- draw prize and stars after clicking on pong

  draw_inventory_settings(game_area, game_state, conf)

  -- dev drawings
  draw_barriers(conf)                   -- draw barriers
  draw_debug_section(game_area, conf)

end -- end love.draw()





--------------- CUSTOM FUNCTIONS --------------
function love.mousepressed( mx, my, mbutton, istouch, presses )
  if check_clicking_on_prize_preview(mx, my, mbutton, game_area, game_state) then
    enter_prize_preview_state()
  elseif check_closing_prize_preview(game_state) then
    leave_prize_preview_state()
    enter_state_1()
  elseif check_clicking_on_pong(mx, my, mbutton, game_state) then
    leave_state_3()
    enter_state_4()
  elseif check_closing_prize(game_state) then
    leave_state_4()
    enter_state_1()
  elseif check_opening_inventory_settings(mx, my, game_area, game_state, conf) then
    enter_state_20()
  elseif check_closing_inventory_settings(mx, my, game_area, game_state) then
    leave_state_20()
    enter_state_1()
  elseif check_clicking_on_settings(mx, my, game_area, game_state) then
    
  end
end



-- Exit on pressing ESC
function love.keypressed(k)
  if k == 'escape' then
    if (game_state == 4) or (game_state == 10) or (game_state == 20) then
      enter_state_1()
    else
      love.event.quit()
    end
  elseif k == 'home' and game_state == 1 then
    enter_state_20()
  end
end