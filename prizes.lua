local success = love.audio.newSource("sounds/success.mp3", "stream")
local fail    = love.audio.newSource("sounds/fail.mp3", "stream")

prizes = {
  blue      = { sound = success, img = love.graphics.newImage('sprites/prizes/blue.png'),      name='S Sketchbook 2018', flying_obj='star' },
  red       = { sound = success, img = love.graphics.newImage('sprites/prizes/red.png'),       name='S Sketchbook 2020', flying_obj='star' },
  green     = { sound = success, img = love.graphics.newImage('sprites/prizes/green.png'),     name='L Sketchbook 2018', flying_obj='star' },
  metallic  = { sound = success, img = love.graphics.newImage('sprites/prizes/metallic.png'),  name='L Sketchbook 2020', flying_obj='star' },
  gold      = { sound = success, img = love.graphics.newImage('sprites/prizes/gold.png'),      name='T-Shirt'          , flying_obj='star' },
  purple    = { sound = success, img = love.graphics.newImage('sprites/prizes/purple.png'),    name='Candy & Snack'    , flying_obj='star' },
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

    -- -- draw stars
    -- if conf.show_stars and (prizes[prize_key].flying_obj == "star") then
    --   for _, v in ipairs(stars) do
    --     love.graphics.setColor(1.0, 1.0, 1.0, v.a)
    --     love.graphics.draw(static_graphics.star, v.x, v.y, v.r, v.s, v.s, ((static_graphics.star:getWidth() * v.s) / 2), ((static_graphics.star:getHeight() * v.s) / 2))
    --   end
    -- -- draw flies
    -- elseif conf.show_flies and (prizes[prize_key].flying_obj == "fly")
    --   for _, v in ipairs(flies) do
    --     love.graphics.setColor(1.0, 1.0, 1.0, v.a)
    --     love.graphics.draw(static_graphics.fly, v.x, v.y, v.r, v.s, v.s, 50, 50)
    --   end
    -- end

    set_default_alpha()
    love.graphics.draw(prizes[prize_key].img, game_area.pos.x.mid - ((prizes[prize_key].img:getWidth() * game_area.ratio) / 2), game_area.pos.y.mid - ((prizes[prize_key].img:getHeight() * game_area.ratio) / 2), 0, game_area.ratio, game_area.ratio)
  end

end