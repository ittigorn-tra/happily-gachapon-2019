pongs_in_window = {
  animation = newAnimation(love.graphics.newImage("sprites/animated_graphics/pongs_in_window.png"), 567, 900, 1, 51),
  x   = (game_area.pos.x.start + (70 * game_area.ratio)),
  y   = (game_area.pos.y.start + (435 * game_area.ratio)),
  sx  = game_area.ratio,
  sy  = game_area.ratio
}

function draw_pong_in_window(game_area)
  local spriteNum = math.floor(pongs_in_window.animation.currentTime / pongs_in_window.animation.duration * #pongs_in_window.animation.quads) + 1
  love.graphics.draw(pongs_in_window.animation.spriteSheet, pongs_in_window.animation.quads[spriteNum], pongs_in_window.x, pongs_in_window.y, 0, pongs_in_window.sx, pongs_in_window.sy)
end