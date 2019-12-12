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