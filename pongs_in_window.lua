function new_pongs_in_window_animation()
  return new_animation(love.graphics.newImage("sprites/animated_graphics/pongs_in_window.png"), 567, 900, 1, 51)
end

pongs_in_window = {
  animation = new_pongs_in_window_animation(),
}

function update_pongs_in_window(game_state, button_state, dt)
  if (game_state == 2) or (button_state == 1) then
    pongs_in_window.animation.currentTime = pongs_in_window.animation.currentTime + dt
    if pongs_in_window.animation.currentTime >= pongs_in_window.animation.duration then
      pongs_in_window.animation.currentTime = pongs_in_window.animation.currentTime - pongs_in_window.animation.duration
    end
  end
end

function draw_pong_in_window(game_area, conf)
  if conf.semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, conf.semi_transparent_val)
  end
  local sprite_num = math.floor(pongs_in_window.animation.currentTime / pongs_in_window.animation.duration * #pongs_in_window.animation.quads) + 1
  local quad = pongs_in_window.animation.quads[sprite_num]

  -- prevent bug in android
  if quad == nil then
    for i=1, 10 do
      pongs_in_window.animation = new_pongs_in_window_animation()
      if pongs_in_window.animation ~= nil then break end
    end
    sprite_num = math.floor(pongs_in_window.animation.currentTime / pongs_in_window.animation.duration * #pongs_in_window.animation.quads) + 1
    quad = pongs_in_window.animation.quads[sprite_num]
  end

  love.graphics.draw(pongs_in_window.animation.spriteSheet, quad, translate_dim(game_area, 70, 435, nil, 1, 1))
  if conf.semi_transparent then
    set_default_alpha()
  end
end