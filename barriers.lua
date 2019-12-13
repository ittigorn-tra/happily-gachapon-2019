-- barriers
barriers = {}

barriers.barrier_l    = {}
barriers.barrier_l.h  = game_area.dim.h
barriers.barrier_l.w  = (30 * game_area.ratio)
barriers.barrier_l.x  = game_area.pos.x.start + (75 * game_area.ratio) -- set offset
barriers.barrier_l.y  = game_area.pos.y.start

barriers.barrier_r    = {}
barriers.barrier_r.h  = game_area.dim.h
barriers.barrier_r.w  = (30 * game_area.ratio)
barriers.barrier_r.x  = game_area.pos.x.start + (600 * game_area.ratio) -- set offset
barriers.barrier_r.y  = game_area.pos.y.start

barriers.barrier_b    = {}
barriers.barrier_b.h  = (30 * game_area.ratio)
barriers.barrier_b.w  = game_area.dim.w
barriers.barrier_b.x  = game_area.pos.x.start
barriers.barrier_b.y  = (1755 * game_area.ratio) -- set offset

barriers.barrier_t    = {}
barriers.barrier_t.h  = (30 * game_area.ratio)
barriers.barrier_t.w  = game_area.dim.w
barriers.barrier_t.x  = game_area.pos.x.start
barriers.barrier_t.y  = game_area.pos.y.start

barriers.ledge    = {}
barriers.ledge.h  = (30 * game_area.ratio)
barriers.ledge.w  = (130 * game_area.ratio)
barriers.ledge.x  = game_area.pos.x.start + (100 * game_area.ratio)
barriers.ledge.y  = game_area.pos.y.start + (250 * game_area.ratio)

barriers.wedge    = {}
barriers.wedge.h  = (30 * game_area.ratio)
barriers.wedge.w  = (330 * game_area.ratio)
barriers.wedge.x  = game_area.pos.x.start + (370 * game_area.ratio)
barriers.wedge.y  = game_area.pos.y.start + (100 * game_area.ratio)
barriers.wedge.r  = -15.0

function draw_barriers(conf)
  if conf.paint_hidden_structures then
    love.graphics.setColor(0.63, 0.28, 0.05, 0.6)
    love.graphics.polygon("fill", barriers.barrier_l.body:getWorldPoints(barriers.barrier_l.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_r.body:getWorldPoints(barriers.barrier_r.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_b.body:getWorldPoints(barriers.barrier_b.shape:getPoints()))
    love.graphics.polygon("fill", barriers.barrier_t.body:getWorldPoints(barriers.barrier_t.shape:getPoints()))
    love.graphics.polygon("fill", barriers.ledge.body:getWorldPoints(barriers.ledge.shape:getPoints()))
    love.graphics.polygon("fill", barriers.wedge.body:getWorldPoints(barriers.wedge.shape:getPoints()))
  end
end