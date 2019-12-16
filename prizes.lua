stars = {}
flies = {}

prizes = {
  blue      = { sound='success', img=love.graphics.newImage('sprites/prizes/blue.png'),      name='S Sketchbook 2018', flying_obj='star' },
  red       = { sound='success', img=love.graphics.newImage('sprites/prizes/red.png'),       name='S Sketchbook 2020', flying_obj='star' },
  green     = { sound='success', img=love.graphics.newImage('sprites/prizes/green.png'),     name='L Sketchbook 2018', flying_obj='star' },
  metallic  = { sound='success', img=love.graphics.newImage('sprites/prizes/metallic.png'),  name='L Sketchbook 2020', flying_obj='star' },
  gold      = { sound='success', img=love.graphics.newImage('sprites/prizes/gold.png'),      name='T-Shirt'          , flying_obj='star' },
  purple    = { sound='success', img=love.graphics.newImage('sprites/prizes/purple.png'),    name='Candy & Snack'    , flying_obj='star' },
}

load_inventory_from_saved_file(conf)
save_current_inventory(conf)

-- load chances
for k, v in pairs(conf.prize_chances) do
  prizes[k].chance = v
end

-- mapping chances
prize_chance_map = {}
local cum_chances = -1
for k, v in pairs(prizes) do
  if v.chance ~= 'else' then
    prize_chance_map[k] = {
      min = cum_chances + 1,
      max = cum_chances + v.chance,
    }
    cum_chances = cum_chances + v.chance
  end
end
for k, v in pairs(prizes) do
  if v.chance == 'else' then
    prize_chance_map[k] = {
      min = cum_chances + 1,
      max = 99,
    }
  end
end

-- functions

function determine_prize(conf)
  rand_x = love.math.random(0, 99)
  local prize_available = false
  for i = 1, 1000, 1 do
    for k, v in pairs(prize_chance_map) do
      if (rand_x >= v.min) and (rand_x <= v.max) then
        if prizes[k].qty > 0 then
          prize_key = k
          adjust_current_inventory(k, -1)
          save_current_inventory(conf)
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

function draw_prize(game_area, game_state, conf)

  if game_state == 4 then
    love.graphics.setColor(0, 0, 0, conf.show_price_fade_percentage)
    love.graphics.rectangle('fill', game_area.pos.x.start, game_area.pos.y.start, game_area.dim.w, game_area.dim.h)
    set_default_alpha()

    -- draw stars
    if conf.show_stars and (prizes[prize_key].flying_obj == "star") then
      for _, v in ipairs(stars) do
        love.graphics.setColor(1.0, 1.0, 1.0, v.a)
        love.graphics.draw(static_graphics.star, v.x, v.y, v.r, v.sx, v.sy, ((static_graphics.star:getWidth() * v.sx) / 2), ((static_graphics.star:getHeight() * v.sy) / 2))
      end
    -- -- draw flies
    -- elseif conf.show_flies and (prizes[prize_key].flying_obj == "fly")
    --   for _, v in ipairs(flies) do
    --     love.graphics.setColor(1.0, 1.0, 1.0, v.a)
    --     love.graphics.draw(static_graphics.fly, v.x, v.y, v.r, v.s, v.s, 50, 50)
    --   end
    end

    set_default_alpha()
    love.graphics.draw(prizes[prize_key].img, game_area.pos.x.mid - ((prizes[prize_key].img:getWidth() * game_area.ratio) / 2), game_area.pos.y.mid - ((prizes[prize_key].img:getHeight() * game_area.ratio) / 2), 0, game_area.ratio, game_area.ratio)
  end

end


function update_stars(dt, game_area, conf)

  if conf.show_stars then
    for i, v in ipairs(stars) do
      v.x = v.x + (v.dx * dt)                   -- update x
      v.y = v.y + (v.dy * dt)                   -- update y
      v.r = v.r + (conf.star.rotate_speed * dt) -- update r

      local dist = calc_distance(v.x, v.y, game_area.pos.x.mid, game_area.pos.y.mid)

      v.sx = (dist / (conf.star.scale_speed * game_area.ratio)) -- update sx
      v.sy = (dist / (conf.star.scale_speed * game_area.ratio)) -- update sy

      -- calculate alpha
      local a = (dist / (conf.star.fade_speed * game_area.ratio))
      if a > 1 then a = 1 end
      -- fade out if out of game area
      if  (v.x < (game_area.pos.x.start - (static_graphics.star:getWidth() * v.sx ))) or 
          (v.x > (game_area.pos.x.stop  + (static_graphics.star:getWidth() * v.sx ))) or 
          (v.y < (game_area.pos.y.start - (static_graphics.star:getHeight() * v.sy ))) or 
          (v.y > (game_area.pos.y.stop  + (static_graphics.star:getHeight() * v.sy ))) then
        a = v.a - 0.04
        if a < 0 then a = 0 end
    end
      v.a = a

      -- check if stars are out of screen, if so, delete them
      if  (v.x < (0 - (static_graphics.star:getWidth() * v.sx ))) or 
          (v.x > (love.graphics.getWidth() + (static_graphics.star:getWidth() * v.sx ))) or 
          (v.y < (0 - (static_graphics.star:getHeight() * v.sy ))) or 
          (v.y > (love.graphics.getHeight() + (static_graphics.star:getHeight() * v.sy ))) then
        table.remove( stars, i )
      end
    end
    
    -- spawn stars
    if (#stars < conf.star.max) and (math.random(1,100) > 50) then
      local star_x = (love.graphics.getWidth() / 2)
      local star_y = (love.graphics.getHeight() / 2)
      local star_r = 0
  
      local angle = math.random(0, 628319) / 100000
      local rotation = 1
      local scale = conf.star.min_scale
  
      local direction_x = conf.star.speed * math.cos(angle)
      local direction_y = conf.star.speed * math.sin(angle)
  
      table.insert( stars, { 
        x = star_x, 
        y = star_y, 
        dx = direction_x, 
        dy = direction_y, 
        r = rotation, 
        sx = scale, 
        sy = scale, 
        a = 0.0 
      } )
    
    end

  end

end

-- function update_flies(dt, game_area, conf)

--   if conf.show_flies and (prize_key == "purple") then
--     for i, v in ipairs(flies) do
--       v.x = v.x - (v.dx * dt) -- update x
--       v.y = v.y - (v.dy * dt) -- update y

--       if v.r + (fly.rotate_speed * dt) > 1.0472 then
--         v.swing_plus = false
--       elseif v.r + (fly.rotate_speed * dt) < 2.0944 then
--         v.swing_plus = true
--       end

--       if v.swing_plus then
--         v.r = v.r + (fly.rotate_speed * dt) -- update r
--       else
--         v.r = v.r - (fly.rotate_speed * dt) -- update r
--       end

--       v.s = (calc_distance(v.x, v.y, (love.graphics.getWidth() / 2), (love.graphics.getHeight() / 2) + fly.origin_y_offset) / fly.scale_speed) -- update s

--       local a = (calc_distance(v.x, v.y, (love.graphics.getWidth() / 2), (love.graphics.getHeight() / 2) + fly.origin_y_offset) / fly.fade_speed)
--       if a > 1 then a = 1 end
--       v.a = a

--       -- check if flies are out of screen, if so, delete them
--       if  (v.x < -(static_graphics.fly:getWidth() * v.s )) or 
--           (v.x > (love.graphics.getWidth() + (static_graphics.fly:getWidth() * v.s ))) or 
--           (v.y < -(static_graphics.fly:getHeight() * v.s )) or 
--           (v.y > (love.graphics.getHeight() + (static_graphics.fly:getHeight() * v.s ))) then
--         table.remove( flies, i )
--       end
--     end
    
--     -- spawn flies
--     if (#flies < fly.max) and (math.random(1,100) > 75) then
--       local fly_x = (love.graphics.getWidth() / 2)
--       local fly_y = (love.graphics.getHeight() / 2) + fly.origin_y_offset
--       local fly_r = 0
  
--       local angle = math.random((1.0472 * 100000), (2.0944 * 100000)) / 100000
--       local rotation = 0
--       local scale = fly.min_scale
  
--       local direction_x = fly.speed * math.cos(angle)
--       local direction_y = fly.speed * math.sin(angle)
  
--       table.insert( flies, { x = fly_x, y = fly_y, dx = direction_x, dy = direction_y, r = rotation, s = scale, a = 0.0, swing_plus = true } )
--     end

--   end

-- end