button_state    = 0
button_pressed  = false

button = {}

-- button up
button.up = {
  img = love.graphics.newImage('sprites/interactive_graphics/button_up.png')
}
button.up = translate_dim(game_area, 844, 1184, nil, 1, 1, button.up)
button.up.ox = (button.up.img:getWidth()  / 2)
button.up.oy = (button.up.img:getHeight() / 2)

-- button down
button.down = {
  img = love.graphics.newImage('sprites/interactive_graphics/button_down.png')
}
button.down = translate_dim(game_area, 843, 1183, nil, 1, 1, button.down)
button.down.ox = (button.down.img:getWidth()  / 2)
button.down.oy = (button.down.img:getHeight() / 2)

function draw_button(button_state)
  if button_state == 0 then
    love.graphics.draw(button.up.img, button.up.x, button.up.y, 0, button.up.sx, button.up.sy, button.up.ox, button.up.oy)
  elseif button_state == 1 then
    love.graphics.draw(button.down.img, button.down.x, button.down.y, 0, button.down.sx, button.down.sy, button.down.ox, button.down.oy)
  end
end

-- detect click on the button
function check_button_clicked(game_state, conf, dt)
  local b_state = 0
  if game_state == 1 then
    if love.mouse.isDown(1) or love.mouse.isDown(2) then
      local mx, my = love.mouse.getPosition()
      -- check if x, y is the same as button the image
      if  (
        (calc_distance(mx, my, button.up.x, button.up.y) <= ((button.up.img:getWidth() * button.up.sx) / 2)) 
        and 
        check_if_not_in_state_1_pause_duration(conf)
        ) then
        b_state         = 1
        if not button_pressed then
          button_pressed  = true
          play_pressing_sound()
        end
        if state_2_timer < conf.state_2_duration then
          state_2_timer = state_2_timer + dt
        end
      end
    else
      if button_pressed then
        leave_state_1()
        enter_state_2()
      end
    end
  end
  button_state = b_state
end