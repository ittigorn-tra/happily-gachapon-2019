pongs_in_window = {
  animation = newAnimation(love.graphics.newImage("sprites/animated_graphics/pongs_in_window.png"), 567, 900, 1, 51),
}

function draw_pong_in_window(game_area, conf)
  if conf.semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, conf.semi_transparent_val)
  end
  local spriteNum = math.floor(pongs_in_window.animation.currentTime / pongs_in_window.animation.duration * #pongs_in_window.animation.quads) + 1
  love.graphics.draw(pongs_in_window.animation.spriteSheet, pongs_in_window.animation.quads[spriteNum], translate_dim(game_area, 70, 435, nil, 1, 1))
  if conf.semi_transparent then
    set_default_alpha()
  end
end