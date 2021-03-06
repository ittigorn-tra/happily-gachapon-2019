function new_prize_bubble_animation()
  return new_animation(love.graphics.newImage("sprites/animated_graphics/prize_bubble.png"), 305, 150, 2.5, 51)
end

prize_preview = {}
prize_preview.prize_bubble            = {}
prize_preview.prize_bubble.animation  = new_prize_bubble_animation()
prize_preview.prize_bubble            = translate_dim(game_area, 683, 450, nil, 1, 1, prize_preview.prize_bubble)
prize_preview.button                  = {}
prize_preview.button.img              = love.graphics.newImage('sprites/static_graphics/previews.png')
prize_preview.button                  = translate_dim(game_area, 676, 610, nil, 1, 1, prize_preview.button)
prize_preview.popup                   = {}
prize_preview.popup.img               = love.graphics.newImage('sprites/static_graphics/prizes.png')
prize_preview.popup.x                 = game_area.pos.x.mid - ((prize_preview.popup.img:getWidth() * game_area.ratio) / 2)
prize_preview.popup.y                 = game_area.pos.y.mid - ((prize_preview.popup.img:getHeight() * game_area.ratio) / 2)
prize_preview.popup.r                 = nil
prize_preview.popup.sx                = game_area.ratio
prize_preview.popup.sy                = game_area.ratio

function update_prize_preview_bubble(dt)
  prize_preview.prize_bubble.animation.currentTime = prize_preview.prize_bubble.animation.currentTime + dt
  if prize_preview.prize_bubble.animation.currentTime >= prize_preview.prize_bubble.animation.duration then
    prize_preview.prize_bubble.animation.currentTime = prize_preview.prize_bubble.animation.currentTime - prize_preview.prize_bubble.animation.duration
  end
end

function draw_prize_preview_bubble(game_area)
  local sprite_num = math.floor(prize_preview.prize_bubble.animation.currentTime / prize_preview.prize_bubble.animation.duration * #prize_preview.prize_bubble.animation.quads) + 1
  local quad = prize_preview.prize_bubble.animation.quads[sprite_num]

  -- prevent bug in android
  if quad == nil then
    for i=1, 10 do
      prize_preview.prize_bubble.animation = new_prize_bubble_animation()
      if prize_preview.prize_bubble.animation ~= nil then break end
    end
    sprite_num = math.floor(prize_preview.prize_bubble.animation.currentTime / prize_preview.prize_bubble.animation.duration * #prize_preview.prize_bubble.animation.quads) + 1
    quad = prize_preview.prize_bubble.animation.quads[sprite_num]
  end
  
  love.graphics.draw(prize_preview.prize_bubble.animation.spriteSheet, quad, prize_preview.prize_bubble.x, prize_preview.prize_bubble.y, prize_preview.prize_bubble.r, prize_preview.prize_bubble.sx, prize_preview.prize_bubble.sy)
end

function draw_prize_preview_button(game_area)
  love.graphics.draw(prize_preview.button.img, prize_preview.button.x, prize_preview.button.y, prize_preview.button.r, prize_preview.button.sx, prize_preview.button.sy)
end

function draw_prize_preview_popup(game_area, game_state)
  if game_state == 10 then
    love.graphics.draw(prize_preview.popup.img, prize_preview.popup.x, prize_preview.popup.y, prize_preview.popup.r, prize_preview.popup.sx, prize_preview.popup.sy)
  end
end

function check_clicking_on_prize_preview(mx, my, mbutton, game_area, game_state)
  if check_mouse_within_graphic(mx, my, game_area, prize_preview.button) and (game_state < 2) then
    return true
  else
    return false
  end
end

function check_closing_prize_preview(game_state)
  if game_state == 10 then
    return true
  else
    return false
  end
end

function enter_prize_preview_state()
  leave_state_1()
  game_state = 10
  play_pressing_sound()
end

function leave_prize_preview_state()
  play_pressing_sound()
end