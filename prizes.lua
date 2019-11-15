local success = love.audio.newSource("sounds/success.mp3", "stream")
local fail    = love.audio.newSource("sounds/fail.mp3", "stream")

prizes = {
  blue      = { sound = success, img = love.graphics.newImage('sprites/prizes/blue.png'),      name='S Sketchbook 2018' , chance=15.0},
  red       = { sound = success, img = love.graphics.newImage('sprites/prizes/red.png'),       name='S Sketchbook 2020' , chance=15.0},
  green     = { sound = success, img = love.graphics.newImage('sprites/prizes/green.png'),     name='L Sketchbook 2018' , chance=10.0},
  metallic  = { sound = success, img = love.graphics.newImage('sprites/prizes/metallic.png'),  name='L Sketchbook 2020' , chance=10.0},
  gold      = { sound = success, img = love.graphics.newImage('sprites/prizes/gold.png'),      name='T-Shirt'           , chance=2.0},
  purple    = { sound = fail,    img = love.graphics.newImage('sprites/prizes/purple.png'),    name='Nothing'           , chance='else'},
}

prize_chance_map = {}
local cum_chances = -1
for k, v in pairs(prizes) do
  if v.chance ~= 'else' then
    prize_chance_map[k] = {
      min = cum_chances + 1,
      max = cum_chances + v.chance,
    }
    cum_chances = cum_chances + v.chance
  else
    prize_chance_map[k] = {
      min = cum_chances + 1,
      max = 99,
    }
  end
end