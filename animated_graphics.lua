function newAnimation(image, width, height, duration, frames)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};

  current_frame = 1
  for y = 0, image:getHeight() - height, height do
      for x = 0, image:getWidth() - width, width do
          if current_frame <= frames then
              table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
              current_frame = current_frame + 1
          end
      end
  end

  animation.duration = duration or 1
  animation.currentTime = 0

  return animation
end

-- animations
-- animated_graphics = {}
-- animated_graphics.rewards = newAnimation(love.graphics.newImage("sprites/animated_graphics/reward_bubble.png"), 305, 150, 2.5, 51)
-- animated_graphics.balls   = newAnimation(love.graphics.newImage("sprites/animated_graphics/balls.png"), 567, 900, 1, 51)