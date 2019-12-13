button_state    = 0
button_pressed  = false

button = {}

-- button up
button.up = {
  img = love.graphics.newImage('sprites/interactive_graphics/button_up.png')
}
button.up = translate_dim(game_area, 740, 1080, nil, 1, 1, button.up)

-- button down
button.down = {
  img = love.graphics.newImage('sprites/interactive_graphics/button_down.png')
}
button.down = translate_dim(game_area, 748, 1088, nil, 1, 1, button.down)

function draw_button(button_state)
  if button_state == 0 then
    love.graphics.draw(button.up.img, button.up.x, button.up.y, 0, button.up.sx, button.up.sy)
  elseif button_state == 1 then
    love.graphics.draw(button.down.img, button.down.x, button.down.y, 0, button.down.sx, button.down.sy)
  end
end

-- detect click on the button
function check_button_clicked(game_state)
  local b_state = 0
  if game_state == 1 then
    if love.mouse.isDown(1) or love.mouse.isDown(2) then
      local mx, my = love.mouse.getPosition()
      -- check if x, y is the same as button the image
      if  (
            (mx >= button.up.x) and (mx <= (button.up.x + (button.up.img:getWidth() * button.up.sx)))
            and 
            (my >= button.up.y) and (my <= (button.up.y + (button.up.img:getHeight() * button.up.sx)))
          ) then
        b_state         = 1
        button_pressed  = true
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