------------------------- interactive graphics -------------------------
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
function check_button_clicked()
  local button_state = 0
  if love.mouse.isDown(1) or love.mouse.isDown(2) then
    local mx, my = love.mouse.getPosition()
    -- check if x, y is the same as button the image
    if  (
          (mx >= button.up.x) and (mx <= (button.up.x + (button.up.img:getWidth() * button.up.sx)))
          and 
          (my >= button.up.y) and (my <= (button.up.y + (button.up.img:getHeight() * button.up.sx)))
        ) then
      button_state = 1
    end
  end
  return button_state
end