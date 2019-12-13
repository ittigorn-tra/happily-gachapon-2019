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
pong.initial_pos.x  = (game_area.pos.x.start + (210 * game_area.ratio))
pong.initial_pos.y  = (game_area.pos.y.start + (140 * game_area.ratio))
pong.bounciness     = 0.3
pong.body_radius    = (206 * game_area.ratio) / 2

function draw_pong(prize_key)
  love.graphics.draw(
    pong.img[prize_key], 
    pong.body:getX(), 
    pong.body:getY(), 
    pong.body:getAngle(), 
    game_area.ratio, 
    game_area.ratio, 
    pong.img[prize_key]:getWidth()/2, 
    pong.img[prize_key]:getHeight()/2
  )
  -- love.graphics.circle( "fill", pong.body:getX(), pong.body:getY(), pong.shape:getRadius() )
end