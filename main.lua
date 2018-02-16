class = require 'lib/middleclass'
Stateful = require 'lib/stateful'

require 'game'

local game

function love.load()
  -- Launch Game starting at Main Menu
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, code)
  game:keypressed(key, code)
end

function love.mousepressed(x, y, button, istouch)
  game:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
  game:mousereleased(x, y, button, istouch)
end

function love.mousemoved( x, y, dx, dy, istouch )
   game:mousemoved( x, y, dx, dy, istouch )
end
