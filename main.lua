-- ESC to exit game
-- CLICK on button to play


function calc_game_area(default_width, default_height, default_ratio, screen_width, screen_height)
  screen_ratio = screen_width / screen_height
  dim = { w=0, h=0 }
  pos = { x={ start=0, mid=0, stop=0 }, y={ start=0, mid=0, stop=0 }}
  ratio = 0

  if screen_ratio == default_ratio then
    dim = { w=screen_width, h=screen_height }
    pos = { 
            x={ start=0, mid=screen_width/2, stop=screen_width }, 
            y={ start=0, mid=( screen_height/2 ), stop=screen_height }
          }
    ratio = (screen_width / default_width)
  elseif screen_ratio < default_ratio then -- the screen is taller than expected
    dim = { w=screen_width, h=( screen_width / default_ratio ) }
    pos = { 
            x={ start=0, mid=screen_width/2, stop=screen_width }, 
            y={ 
                start=( ( screen_height/2 ) - ( dim.h / 2 ) ), 
                mid=( screen_height/2 ), 
                stop=( ( screen_height/2 ) + ( dim.h / 2 ) ) 
              }
          }
    ratio = (screen_width / default_width)
  elseif screen_ratio > default_ratio then -- the screen is wider than expected
    dim = { w=( screen_height * default_ratio ), h=screen_height }
    pos = {
            x={ 
              start=( ( screen_width/2 ) - ( dim.w / 2 ) ), 
              mid=( screen_width/2 ), 
              stop=( ( screen_width/2 ) + ( dim.w / 2 ) ) 
            },
            y={ start=0, mid=screen_height/2, stop=screen_height }
          }
    ratio = (screen_height / default_height)
  end

  return { dim=dim, pos=pos, ratio=ratio }

end

function love.load()

  -- SEED RANDOM
  math.randomseed(os.time())

  require('./conf')

  -- SET INITIAL VARIABLES
  game_state = 1
  -- prize_key  = 'blue'

  -- SET WINDOWS RESOLUTION
  love.window.setTitle( 'Happily Gachapon' )
  love.window.setMode( 0, 0, {fullscreen=fullscreen, fullscreentype = "desktop", display=display} )
  screen_width, screen_height = love.graphics.getWidth(), love.graphics.getHeight()
  game_area = calc_game_area(default_width, default_height, default_ratio, screen_width, screen_height)

  -- import other modules
  -- require('./barriers')
  -- require('./prizes')
  -- require('./pong')
  require('./static_graphics')
  -- require('./interactive_graphics')
  -- require('./animated_graphics')

end -- end love.load()




function love.update(dt)
  
  current_dt = dt

end -- end love.update()




function love.draw()

  -- background
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

  -- bg
  love.graphics.draw(static_graphics.bg, game_area.pos.x.start, game_area.pos.y.start, 0, game_area.ratio, game_area.ratio)

  -- pong
  -- love.graphics.draw(pong.img[prize_key], pong.body:getX(), pong.body:getY(), pong.body:getAngle(), nil, nil, pong.img[prize_key]:getWidth()/2, pong.img[prize_key]:getWidth()/2)

  -- fg
  if semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, 0.3)
  end
  love.graphics.draw(static_graphics.fg, game_area.pos.x.start, game_area.pos.y.start, 0, game_area.ratio, game_area.ratio)

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