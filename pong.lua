pong = {} -- table to hold our physical pong
pong.state          = 1
pong.img            = {}
pong.img.blue       = love.graphics.newImage("sprites/balls/blue.png")
pong.img.gold       = love.graphics.newImage("sprites/balls/gold.png")
pong.img.green      = love.graphics.newImage("sprites/balls/green.png")
pong.img.metallic   = love.graphics.newImage("sprites/balls/metallic.png")
pong.img.purple     = love.graphics.newImage("sprites/balls/purple.png")
pong.img.red        = love.graphics.newImage("sprites/balls/red.png")
pong.initial_pos    = {}
pong.initial_pos.x  = 210
pong.initial_pos.y  = 140