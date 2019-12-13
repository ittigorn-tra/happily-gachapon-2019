prize_preview = {}
prize_preview.prize_bubble            = {}
prize_preview.prize_bubble.animation  = new_animation(love.graphics.newImage("sprites/animated_graphics/prize_bubble.png"), 305, 150, 2.5, 51)
prize_preview.prize_bubble            = translate_dim(game_area, 683, 450, nil, 1, 1, prize_preview.prize_bubble)
prize_preview.button                  = {}
prize_preview.button.img              = love.graphics.newImage('sprites/static_graphics/previews.png')
prize_preview.button                  = translate_dim(game_area, 676, 610, nil, 1, 1, prize_preview.button)
prize_preview.popup                   = {}
prize_preview.popup                   = love.graphics.newImage('sprites/static_graphics/prizes.png')

function update_prize_preview_bubble(dt)
  prize_preview.prize_bubble.animation.currentTime = prize_preview.prize_bubble.animation.currentTime + dt
  if prize_preview.prize_bubble.animation.currentTime >= prize_preview.prize_bubble.animation.duration then
    prize_preview.prize_bubble.animation.currentTime = prize_preview.prize_bubble.animation.currentTime - prize_preview.prize_bubble.animation.duration
  end
end

function draw_prize_preview_bubble(game_area)
  local sprite_num = math.floor(prize_preview.prize_bubble.animation.currentTime / prize_preview.prize_bubble.animation.duration * #prize_preview.prize_bubble.animation.quads) + 1
  love.graphics.draw(prize_preview.prize_bubble.animation.spriteSheet, prize_preview.prize_bubble.animation.quads[sprite_num], prize_preview.prize_bubble.x, prize_preview.prize_bubble.y, prize_preview.prize_bubble.r, prize_preview.prize_bubble.sx, prize_preview.prize_bubble.sy)
end

function draw_prize_preview_button(game_area)
  love.graphics.draw(prize_preview.button.img, prize_preview.button.x, prize_preview.button.y, prize_preview.button.r, prize_preview.button.sx, prize_preview.button.sy)
end