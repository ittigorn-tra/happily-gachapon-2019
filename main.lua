-- ESC to exit game
-- CLICK on button to play

function newAnimation(image, width, height, duration, frames)
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

function load_colliding_sound()
  if sound_on then
    local sound_arr = {}
    table.insert(sound_arr, love.audio.newSource("sounds/colliding.mp3", "static"))
    for i = 1, 10, 1 do
      table.insert(sound_arr, sound_arr[1]:clone())
    end
    return sound_arr
  end
end

function determine_prize()
  rand_x = love.math.random(0, 99)
  local prize_available = false
  for i = 1, 1000, 1 do
    for k, v in pairs(prize_chance_map) do
      if (rand_x >= v.min) and (rand_x <= v.max) then
        if prizes[k].qty > 0 then
          prize_key = k
          prizes[k].qty = prizes[k].qty - 1
          prize_available = true
          break
        end
      end
    end
    if prize_available then
      break
    else
      rand_x = love.math.random(0, 99)
    end
  end
end

function reset_game_state() -- return to default state
  sounds.press:play()
  game_state          = 1
  since_last_pressed  = 0
  pong_kicked         = false
  pong.body:setPosition(pong.initial_pos.x, pong.initial_pos.y)
  pong.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
  pong.body:setAngularVelocity(0)
end

function enter_state_2(dt) -- determining prize and drop ball state
  state_1_timer = 0
  if sound_on and bg_music_on then
    sounds.bg_music:setVolume(dimmed_bg_music_volume)
  end
  since_last_pressed = since_last_pressed + dt
  if (not pong_kicked) and (since_last_pressed > (state_2_duration/2)) then
    determine_prize()
    pong.body:setLinearVelocity(love.math.random( 800, 2000 ), love.math.random( -10, -100 ))
    pong_kicked = true
  end
end

function enter_state_3() -- determining prize and drop ball state
  game_state          = 3
end

function enter_state_4() -- show prize state
  game_state          = 4
  if sound_on then
    if not (prizes[prize_key].sound == nil) then
      prizes[prize_key].sound:play()
    end
  end
end

function love.load()

  -- DEV VARIABLES
  paint_hidden_structures   = false
  semi_transparent          = false
  show_debug_messages       = true

  -- CONFIGS
  display                     = 2
  fullscreen                  = true
  forceWidth, forceHeight     = 1080, 1920
  sound_on                    = true
  bg_music_on                 = true
  state_2_duration            = 2.0
  show_price_fade_percentage  = 0.7
  default_bg_music_volume     = 1.0
  dimmed_bg_music_volume      = 0.4
  state_1_pause_duration      = 0.7 -- pausing time before the button can be clicked again after entering this state

  -- SET VARIABLES
  game_state          = 1
  button_state        = 0
  ball_circling_state = false
  since_last_pressed  = 0
  pong_kicked         = false
  current_dt          = 0
  rand_x              = 0
  state_1_timer       = state_1_pause_duration
  prize_key           = 'blue'

  -- SET WINDOWS RESOLUTION
  love.window.setMode( 1080, 1920, {fullscreen=fullscreen, fullscreentype = "desktop", display=display} )
  screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
  love.window.setTitle( 'Happily Gachapon' )

  require('./barriers')
  require('./prizes')
  require('./pong')
  require('./static_graphics')
  require('./interactive_graphics')
  require('./animated_graphics')

  -- SET UP PHYSICS
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  -- physics objects setup
  barriers.barrier_l.body     = love.physics.newBody(world, barriers.barrier_l.w/2, barriers.barrier_l.h/2)
  barriers.barrier_l.shape    = love.physics.newRectangleShape(barriers.barrier_l.x, barriers.barrier_l.y, barriers.barrier_l.w, barriers.barrier_l.h)
  barriers.barrier_l.fixture  = love.physics.newFixture(barriers.barrier_l.body, barriers.barrier_l.shape)

  barriers.barrier_r.body     = love.physics.newBody(world, barriers.barrier_r.w/2, barriers.barrier_r.h/2)
  barriers.barrier_r.shape    = love.physics.newRectangleShape(barriers.barrier_r.x, barriers.barrier_r.y, barriers.barrier_r.w, barriers.barrier_r.h)
  barriers.barrier_r.fixture  = love.physics.newFixture(barriers.barrier_r.body, barriers.barrier_r.shape)

  barriers.barrier_b.body     = love.physics.newBody(world, barriers.barrier_b.w/2, barriers.barrier_b.h/2)
  barriers.barrier_b.shape    = love.physics.newRectangleShape(barriers.barrier_b.x, barriers.barrier_b.y, barriers.barrier_b.w, barriers.barrier_b.h)
  barriers.barrier_b.fixture  = love.physics.newFixture(barriers.barrier_b.body, barriers.barrier_b.shape)

  barriers.barrier_t.body     = love.physics.newBody(world, barriers.barrier_t.w/2, barriers.barrier_t.h/2)
  barriers.barrier_t.shape    = love.physics.newRectangleShape(barriers.barrier_t.x, barriers.barrier_t.y, barriers.barrier_t.w, barriers.barrier_t.h)
  barriers.barrier_t.fixture  = love.physics.newFixture(barriers.barrier_t.body, barriers.barrier_t.shape)

  barriers.ledge.body         = love.physics.newBody(world, barriers.ledge.w/2, barriers.ledge.h/2)
  barriers.ledge.shape        = love.physics.newRectangleShape(barriers.ledge.x, barriers.ledge.y, barriers.ledge.w, barriers.ledge.h)
  barriers.ledge.fixture      = love.physics.newFixture(barriers.ledge.body, barriers.ledge.shape)

  barriers.wedge.body         = love.physics.newBody(world, barriers.wedge.w/2, barriers.wedge.h/2)
  barriers.wedge.shape        = love.physics.newRectangleShape(barriers.wedge.x, barriers.wedge.y, barriers.wedge.w, barriers.wedge.h, barriers.wedge.r)
  barriers.wedge.fixture      = love.physics.newFixture(barriers.wedge.body, barriers.wedge.shape)

  pong.body           = love.physics.newBody(world, pong.initial_pos.x, pong.initial_pos.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  pong.shape          = love.physics.newCircleShape(206/2)
  pong.fixture        = love.physics.newFixture(pong.body, pong.shape, 1) -- Attach fixture to body and give it a density of 1.
  pong.fixture:setRestitution(0.3) --let the ball bounce

  -- sounds
  if sound_on then
    sounds = {}
    sounds.press    = love.audio.newSource("sounds/press.mp3", "static")
    sounds.collide  = load_colliding_sound()
    sounds.click    = love.audio.newSource("sounds/click.wav", "static")
    sounds.bg_music = love.audio.newSource('sounds/soundtrack.mp3', 'stream')
    if bg_music_on then
      sounds.bg_music:setLooping( true )
      sounds.bg_music:play()
    end
  end

end -- end love.load()




function love.update(dt)
  
  current_dt = dt
  world:update(dt) --this puts the world into motion

  if game_state == 1 then

    if sound_on and bg_music_on then
      -- gradualy increase music volume in idle state
      local curent_bg_volume = sounds.bg_music:getVolume()
      if curent_bg_volume < default_bg_music_volume then
        sounds.bg_music:setVolume(curent_bg_volume + .005)
      end
    end

    if state_1_timer < state_1_pause_duration then
      state_1_timer = state_1_timer + dt
    end
  elseif game_state == 2 then
    enter_state_2(dt)
    if since_last_pressed >= state_2_duration then
      enter_state_3()
    end
  end

  -- ANIMATION
  animated_graphics.rewards.currentTime = animated_graphics.rewards.currentTime + dt
  if animated_graphics.rewards.currentTime >= animated_graphics.rewards.duration then
    animated_graphics.rewards.currentTime = animated_graphics.rewards.currentTime - animated_graphics.rewards.duration
  end
  if ((game_state == 2) or ball_circling_state) then
    animated_graphics.balls.currentTime = animated_graphics.balls.currentTime + dt
    if animated_graphics.balls.currentTime >= animated_graphics.balls.duration then
      animated_graphics.balls.currentTime = animated_graphics.balls.currentTime - animated_graphics.balls.duration
    end
  end

  -- detect click on the button
  if love.mouse.isDown(1) or love.mouse.isDown(2) then
    local x, y = love.mouse.getPosition()
    -- check if x, y is the same as button the image
    if  (
          (x >= interactive_graphics.button_up.x) and (x <= (interactive_graphics.button_up.x + interactive_graphics.button_up.img:getWidth())) 
          and 
          (y >= interactive_graphics.button_up.y) and (y <= (interactive_graphics.button_up.y + interactive_graphics.button_up.img:getHeight()))
          and 
          (game_state < 2) 
          and
          (state_1_timer >= state_1_pause_duration)
        ) then
      button_state = 1
      if sound_on then
        sounds.press:play()
      end
      game_state = 2
    elseif  ((x >= 100) and (x <= 100 + 500) and (y >= 500) and (y <= 500 + 830) and (game_state < 2) and (state_1_timer >= state_1_pause_duration)) then
      ball_circling_state = true
    end
  else
    button_state = 0
    ball_circling_state = false
  end
end -- end love.update()




function love.draw()

  -- background
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

  -- bg
  love.graphics.draw(static_graphics.bg, 0, 0, 0, love.graphics.getWidth()/static_graphics.bg:getWidth(), love.graphics.getHeight()/static_graphics.bg:getHeight())

  -- pong
  love.graphics.draw(pong.img[prize_key], pong.body:getX(), pong.body:getY(), pong.body:getAngle(), nil, nil, pong.img[prize_key]:getWidth()/2, pong.img[prize_key]:getWidth()/2)

  -- fg
  if semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, 0.3)
  end

  local spriteNum = math.floor(animated_graphics.balls.currentTime / animated_graphics.balls.duration * #animated_graphics.balls.quads) + 1
  love.graphics.draw(animated_graphics.balls.spriteSheet, animated_graphics.balls.quads[spriteNum], 60, 450, 0, 1, 1)

  love.graphics.draw(static_graphics.fg, 0, 0, 0, love.graphics.getWidth()/static_graphics.fg:getWidth(), love.graphics.getHeight()/static_graphics.fg:getHeight())
  -- preview
  love.graphics.draw(static_graphics.preview, love.graphics.getWidth()-static_graphics.preview:getWidth()-80, (love.graphics.getHeight()/2)-static_graphics.preview:getHeight()-140, 0, 1, 1)
  -- animation
  local spriteNum = math.floor(animated_graphics.rewards.currentTime / animated_graphics.rewards.duration * #animated_graphics.rewards.quads) + 1
  love.graphics.draw(animated_graphics.rewards.spriteSheet, animated_graphics.rewards.quads[spriteNum], 683, 450, 0, 1, 1)

  if button_state == 0 then
    love.graphics.draw(interactive_graphics.button_up.img, interactive_graphics.button_up.x, interactive_graphics.button_up.y, 0, 1, 1)
  elseif button_state == 1 then
    love.graphics.draw(interactive_graphics.button_down.img, interactive_graphics.button_down.x, interactive_graphics.button_down.y, 0, 1, 1)
  end

  

  -- show prize state
  if game_state == 4 then
    love.graphics.setColor(0,0,0,show_price_fade_percentage)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255,255,255,1)

    love.graphics.draw(prizes[prize_key].img, love.graphics.getWidth()/2 - (prizes[prize_key].img:getWidth()/2), love.graphics.getHeight()/2 - (prizes[prize_key].img:getHeight()/2), 0, 1, 1)
  elseif game_state == 10 then
    love.graphics.setColor(0,0,0,show_price_fade_percentage)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255,255,255,1)
    love.graphics.draw(static_graphics.prizes, love.graphics.getWidth()/2 - (static_graphics.prizes:getWidth()/2), love.graphics.getHeight()/2 - (static_graphics.prizes:getHeight()/2), 0, 1, 1)
  end




  -- show barriers
  if paint_hidden_structures then
    love.graphics.setColor(0.63, 0.28, 0.05)
    love.graphics.polygon("fill", barriers.barrier_l.body:getWorldPoints(barriers.barrier_l.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_r.body:getWorldPoints(barriers.barrier_r.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_b.body:getWorldPoints(barriers.barrier_b.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_t.body:getWorldPoints(barriers.barrier_t.shape:getPoints()))
    love.graphics.polygon("fill", barriers.ledge.body:getWorldPoints(barriers.ledge.shape:getPoints()))
    love.graphics.polygon("fill", barriers.wedge.body:getWorldPoints(barriers.wedge.shape:getPoints()))
  end
  -- show prizes touch area
  if paint_hidden_structures then
    love.graphics.setColor(0,0,0,.3)
    love.graphics.rectangle('fill', 665, 450, 350, 380)
  end
  -- show ball window touch area
  if paint_hidden_structures then
    love.graphics.setColor(0.0,0.0,1.0,.3)
    love.graphics.rectangle('fill', 100, 500, 500, 830)
  end

  if show_debug_messages then
    love.graphics.setColor(1.0, 1.0, 1.0, 0.8)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 250)
    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
    love.graphics.print('Game State: ' ..game_state, 50, 50)
    love.graphics.print('Button State: ' ..button_state, 50, 70)
    love.graphics.print('Since Last Pressed: ' ..since_last_pressed, 50, 90)
    love.graphics.print('Pong kicked: ' ..(pong_kicked and 'true' or 'false'), 50, 110)
    love.graphics.print('Current dt: ' ..current_dt, 50, 130)
    love.graphics.print('State 1 Timer: ' ..state_1_timer, 50, 150)
    local x, y = pong.body:getLinearVelocity()
    love.graphics.print('Pong Velocity X: ' ..x, 50, 170)
    love.graphics.print('Pong Velocity Y: ' ..y, 50, 190)


    love.graphics.print('Qty Blue: ' ..prizes.blue.qty, 350, 50)
    love.graphics.print('Qty Red: ' ..prizes.red.qty, 350, 70)
    love.graphics.print('Qty Green: ' ..prizes.green.qty, 350, 90)
    love.graphics.print('Qty Metallic: ' ..prizes.metallic.qty, 350, 110)
    love.graphics.print('Qty Gold: ' ..prizes.gold.qty, 350, 130)
    love.graphics.print('Qty Purple: ' ..prizes.purple.qty, 350, 150)

    love.graphics.print('Chance Blue: ' ..prize_chance_map.blue.min ..' - ' ..prize_chance_map.blue.max , 550, 50)
    love.graphics.print('Chance Red: ' ..prize_chance_map.red.min ..' - ' ..prize_chance_map.red.max , 550, 70)
    love.graphics.print('Chance Green: ' ..prize_chance_map.green.min ..' - ' ..prize_chance_map.green.max , 550, 90)
    love.graphics.print('Chance Metallic: ' ..prize_chance_map.metallic.min ..' - ' ..prize_chance_map.metallic.max , 550, 110)
    love.graphics.print('Chance Gold: ' ..prize_chance_map.gold.min ..' - ' ..prize_chance_map.gold.max , 550, 130)
    love.graphics.print('Chance Purple: ' ..prize_chance_map.purple.min ..' - ' ..prize_chance_map.purple.max , 550, 150)
    love.graphics.print('Rand X: ' ..rand_x, 550, 170)

  end

end -- end love.draw()





--------------- CUSTOM FUNCTIONS --------------
function love.mousepressed( x, y, button, istouch, presses )
  -- detect clicking on prize preview area
  if  (
    (x >= 665) and (x <= 665 + 350) 
    and 
    (y >= 450) and (y <= 450 + 380) 
    and 
    (game_state < 2) 
    and
    (state_1_timer >= state_1_pause_duration)
  ) then

    if sound_on then
      sounds.press:play()
    end
    game_state = 10
    state_1_timer = 0
  -- detect clicking on pong
  elseif game_state == 3 then
    if  (
          ((x >= (pong.body:getX() - (pong.img[prize_key]:getWidth() / 2))) and (x <= (pong.body:getX() + (pong.img[prize_key]:getWidth() / 2)))) 
          and 
          ((y >= (pong.body:getY() - (pong.img[prize_key]:getHeight() / 2))) and (y <= (pong.body:getY() + (pong.img[prize_key]:getHeight() / 2)))) 
        ) then
          enter_state_4()
    end
  -- detect clicking to close a panel
  elseif (game_state == 4) or (game_state == 10) then
    reset_game_state()
  end

end

function beginContact(a, b, coll)
  if pong.body:getY() > 1000 then

    local x, y = pong.body:getLinearVelocity()
    local vol = 1.0
    if math.abs(x) + math.abs(y) < 500 then
      vol = .3
    elseif  math.abs(x) + math.abs(y) < 100 then
      vol = .1
    elseif  math.abs(x) + math.abs(y) < 50 then
      vol = .02
    end

    if sound_on then
      for i, s in ipairs(sounds.collide) do
        if not s:isPlaying() then
          s:setVolume(vol)
          s:play()
          break
        end
      end
    end

  end
end


-- Exit on pressing ESC
function love.keypressed(k)
  if k == 'escape' then
     love.event.quit()
  -- elseif k == 'home' and game_state == 2 then
    -- enterIdleState()
  end
end

-- function radToDeg(rad)
--   return rad * (180/math.pi)
-- end