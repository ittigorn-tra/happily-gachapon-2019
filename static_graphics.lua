-- static graphics
static_graphics = {}
static_graphics.bg              = {}
static_graphics.bg.img          = love.graphics.newImage('sprites/static_graphics/bg.png')
static_graphics.fg              = {}
static_graphics.fg.img          = love.graphics.newImage('sprites/static_graphics/fg.png')
static_graphics.preview         = love.graphics.newImage('sprites/static_graphics/previews.png')
static_graphics.prizes          = love.graphics.newImage('sprites/static_graphics/prizes.png')
static_graphics.close           = love.graphics.newImage('sprites/static_graphics/close.png')
static_graphics.mute            = {}
static_graphics.mute.on         = love.graphics.newImage('sprites/static_graphics/mute_on.png')
static_graphics.mute.off        = love.graphics.newImage('sprites/static_graphics/mute_off.png')
static_graphics.mute_music      = {}
static_graphics.mute_music.on   = love.graphics.newImage('sprites/static_graphics/mute_music_on.png')
static_graphics.mute_music.off  = love.graphics.newImage('sprites/static_graphics/mute_music_off.png')
static_graphics.reload          = love.graphics.newImage('sprites/static_graphics/reload.png')
static_graphics.plus            = love.graphics.newImage('sprites/static_graphics/plus.png')
static_graphics.minus           = love.graphics.newImage('sprites/static_graphics/minus.png')
static_graphics.star            = love.graphics.newImage('sprites/static_graphics/star.png')
static_graphics.fly             = love.graphics.newImage('sprites/static_graphics/fly.png')

function draw_bg(game_area)
  love.graphics.draw(static_graphics.bg.img, game_area.pos.x.start, game_area.pos.y.start, 0, game_area.ratio, game_area.ratio)
end

function draw_fg(game_area, conf)
  if conf.semi_transparent then
    love.graphics.setColor(1.0, 1.0, 1.0, 0.3)
  end
  love.graphics.draw(static_graphics.fg.img, game_area.pos.x.start, game_area.pos.y.start, 0, game_area.ratio, game_area.ratio)
end