-- ESC to exit game
-- CLICK on button to play

-- states
-- 10 - prize preview mode


function set_default_alpha()
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
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
  button_state  = 0
  prize_key     = 'blue'

  -- SET WINDOWS RESOLUTION
  love.window.setTitle( 'Happily Gachapon' )
  love.window.setMode( 0, 0, {fullscreen=conf.fullscreen, fullscreentype = conf.fullscreentype, display=conf.display} )
  conf.screen_width, conf.screen_height = love.graphics.getWidth(), love.graphics.getHeight()
  game_area = calc_game_area(conf.default_width, conf.default_height, conf.default_ratio, conf.screen_width, conf.screen_height)

  -- import modules
  require('./inventory_management')
  require('./graphics')
  require('./button')
  require('./barriers')
  require('./prizes')
  require('./pong')
  require('./physics')

  -- animations
  require('./pongs_in_window')
  require('./prize_preview')

  -- states
  require('./state_1')

  -- dev
  require('./debug')

end -- end love.load()




function love.update(dt)
  
  current_dt = dt
  world:update(dt) --this puts the world into motion
  update_prize_preview_bubble(dt)

  button_state = check_button_clicked()

  update_state_1(dt, game_state, conf)

end -- end love.update()




function love.draw()

  -- set solid alpha
  set_default_alpha()

  draw_bg(game_area)                    -- draw bg
  draw_pong_in_window(game_area, conf)  -- pongs in window
  draw_pong(prize_key)                  -- draw pong
  draw_fg(game_area, conf)              -- draw fg
  draw_button(button_state)             -- draw button
  draw_prize_preview_bubble(game_area)  -- draw prize preview button
  draw_prize_preview_button(game_area)  -- draw prize preview button

  -- dev drawings
  draw_barriers(conf)                   -- draw barriers
  draw_debug_section(game_area, conf)

end -- end love.draw()





--------------- CUSTOM FUNCTIONS --------------
function love.mousepressed( mx, my, mbutton, istouch, presses )
  if check_clicking_on_prize_preview(mx, my, mbutton, game_area, game_state, conf) then
    enter_prize_preview_mode()
  end
end



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