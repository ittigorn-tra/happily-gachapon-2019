local success = love.audio.newSource("sounds/success.mp3", "stream")
local fail    = love.audio.newSource("sounds/fail.mp3", "stream")
prizes = {
  blue      = { sound = success, img = love.graphics.newImage('sprites/prizes/blue.png'),      name='S Sketchbook 2018' },
  gold      = { sound = success, img = love.graphics.newImage('sprites/prizes/gold.png'),      name='T-Shirt' },
  green     = { sound = success, img = love.graphics.newImage('sprites/prizes/green.png'),     name='L Sketchbook 2018' },
  metallic  = { sound = success, img = love.graphics.newImage('sprites/prizes/metallic.png'),  name='L Sketchbook 2020' },
  purple    = { sound = fail,    img = love.graphics.newImage('sprites/prizes/purple.png'),    name='Nothing' },
  red       = { sound = success, img = love.graphics.newImage('sprites/prizes/red.png'),       name='S Sketchbook 2020' },
}