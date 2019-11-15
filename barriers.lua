-- barriers
screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
barriers = {}

barriers.barrier_l = {}
barriers.barrier_l.h = screenHeight
barriers.barrier_l.w = 35
barriers.barrier_l.x = 0 + 70 -- set offset
barriers.barrier_l.y = 0

barriers.barrier_r = {}
barriers.barrier_r.h = screenHeight
barriers.barrier_r.w = 30
barriers.barrier_r.x = screenWidth - barriers.barrier_r.w - 455 -- set offset
barriers.barrier_r.y = 0

barriers.barrier_b = {}
barriers.barrier_b.h = 30
barriers.barrier_b.w = screenWidth
barriers.barrier_b.x = 0
barriers.barrier_b.y = screenHeight - barriers.barrier_b.h - 135 -- set offset

barriers.barrier_t = {}
barriers.barrier_t.h = 30
barriers.barrier_t.w = screenWidth
barriers.barrier_t.x = 0
barriers.barrier_t.y = 0 -- set offset

barriers.ledge = {}
barriers.ledge.h = 30
barriers.ledge.w = 130
barriers.ledge.x = 100
barriers.ledge.y = 250

barriers.wedge = {}
barriers.wedge.h = 30
barriers.wedge.w = 330
barriers.wedge.x = 350
barriers.wedge.y = 100
barriers.wedge.r = -15.0