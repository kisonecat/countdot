--- game.lua

Game = class('Game'):include(Stateful)

require 'states/menu'
require 'states/play'
require 'states/pause'
require 'states/choose'
require 'states/check'
-- require 'states/game_over'

function Game:initialize()
  self:gotoState('Play')
end

function Game:exit()
end

function Game:update(dt)
end

function Game:draw()
end

function Game:keypressed(key, code)
  -- Pause game
  if key == 'p' then
    self:pushState('Pause')
  end
end

function Game:mousepressed(x, y, button, isTouch)
end

function Game:mousereleased(x, y, button, isTouch)
end

function Game:mousemoved( x, y, dx, dy, istouch )
end
