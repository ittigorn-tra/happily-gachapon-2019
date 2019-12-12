-- interactive graphics
interactive_graphics = {}
interactive_graphics.button_up        = {}
interactive_graphics.button_up.img    = love.graphics.newImage('sprites/interactive_graphics/button_up.png')
interactive_graphics.button_up.x      = game_area.pos.x.start + (740 * game_area.ratio)
interactive_graphics.button_up.y      = game_area.pos.y.start + (1080 * game_area.ratio)
interactive_graphics.button_up.sx     = game_area.ratio
interactive_graphics.button_up.sy     = game_area.ratio
interactive_graphics.button_down      = {}
interactive_graphics.button_down.img  = love.graphics.newImage('sprites/interactive_graphics/button_down.png')
interactive_graphics.button_down.x    = game_area.pos.x.start + (748 * game_area.ratio)
interactive_graphics.button_down.y    = game_area.pos.x.start + (1088 * game_area.ratio)
interactive_graphics.button_down.sx     = game_area.ratio
interactive_graphics.button_down.sy     = game_area.ratio