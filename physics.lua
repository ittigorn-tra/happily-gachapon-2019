-- SET UP PHYSICS
love.physics.setMeter(64) --the height of a meter our worlds will be 64px
world = love.physics.newWorld(0, 9.81 * 64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
world:setCallbacks(beginContact, endContact, preSolve, postSolve)

-- physics objects setup

barriers.barrier_l.body     = love.physics.newBody(world, barriers.barrier_l.w/2, barriers.barrier_l.h/2)
barriers.barrier_l.shape    = love.physics.newRectangleShape(barriers.barrier_l.x, barriers.barrier_l.y, barriers.barrier_l.w, barriers.barrier_l.h)
barriers.barrier_l.fixture  = love.physics.newFixture(barriers.barrier_l.body, barriers.barrier_l.shape)

barriers.barrier_r.body     = love.physics.newBody(world, barriers.barrier_r.w/2, barriers.barrier_r.h/2)
barriers.barrier_r.shape    = love.physics.newRectangleShape(barriers.barrier_r.x, barriers.barrier_r.y, barriers.barrier_r.w, barriers.barrier_r.h)
barriers.barrier_r.fixture  = love.physics.newFixture(barriers.barrier_r.body, barriers.barrier_r.shape)

barriers.barrier_b.body     = love.physics.newBody(world, barriers.barrier_b.w/2, barriers.barrier_b.h/2)
barriers.barrier_b.shape    = love.physics.newRectangleShape(barriers.barrier_b.x, barriers.barrier_b.y, barriers.barrier_b.w, barriers.barrier_b.h)
barriers.barrier_b.fixture  = love.physics.newFixture(barriers.barrier_b.body, barriers.barrier_b.shape)

barriers.barrier_t.body     = love.physics.newBody(world, barriers.barrier_t.w/2, barriers.barrier_t.h/2)
barriers.barrier_t.shape    = love.physics.newRectangleShape(barriers.barrier_t.x, barriers.barrier_t.y, barriers.barrier_t.w, barriers.barrier_t.h)
barriers.barrier_t.fixture  = love.physics.newFixture(barriers.barrier_t.body, barriers.barrier_t.shape)

barriers.ledge.body         = love.physics.newBody(world, barriers.ledge.w/2, barriers.ledge.h/2)
barriers.ledge.shape        = love.physics.newRectangleShape(barriers.ledge.x, barriers.ledge.y, barriers.ledge.w, barriers.ledge.h)
barriers.ledge.fixture      = love.physics.newFixture(barriers.ledge.body, barriers.ledge.shape)

barriers.wedge.body         = love.physics.newBody(world, barriers.wedge.w/2, barriers.wedge.h/2)
barriers.wedge.shape        = love.physics.newRectangleShape(barriers.wedge.x, barriers.wedge.y, barriers.wedge.w, barriers.wedge.h, barriers.wedge.r)
barriers.wedge.fixture      = love.physics.newFixture(barriers.wedge.body, barriers.wedge.shape)

pong.body           = love.physics.newBody(world, pong.initial_pos.x, pong.initial_pos.y, "dynamic")
pong.shape          = love.physics.newCircleShape(pong.body_radius)
pong.fixture        = love.physics.newFixture(pong.body, pong.shape, 1) -- Attach fixture to body and give it a density of 1.
pong.fixture:setRestitution(pong.bounciness) --let the ball bounce

-- end physics objects setup
