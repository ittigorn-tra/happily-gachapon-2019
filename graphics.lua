------------------------- static graphics -------------------------
static_graphics = {}
static_graphics.bg              = love.graphics.newImage('sprites/static_graphics/bg.png')
static_graphics.fg              = love.graphics.newImage('sprites/static_graphics/fg.png')
static_graphics.star            = love.graphics.newImage('sprites/static_graphics/star.png')
static_graphics.fly             = love.graphics.newImage('sprites/static_graphics/fly.png')

function draw_bg(game_area)
  love.graphics.draw(static_graphics.bg, translate_dim(game_area, 0, 0, nil, 1, 1))
end

function draw_fg(game_area, conf)
  if conf.semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, conf.semi_transparent_val)
  end
  love.graphics.draw(static_graphics.fg, translate_dim(game_area, 0, 0, nil, 1, 1))
  if conf.semi_transparent then
    set_default_alpha()
  end
end