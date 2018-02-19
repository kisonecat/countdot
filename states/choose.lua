-- states/play.lua

local Choose = Game:addState('Choose')

local dots = require 'dots'
local cards = require 'cards'

local direction = 0
local directionMaximum = 0
local lastTime
local pressed = false
local mouseSpeed = 2
local radius = 100
local lockTime = nil
local lockDirection = nil
local everLocked = nil
local startTime = nil

function Choose:initialize()
   cards.load()
end

function Choose:enteredState()
   direction = 0
   lastTime = love.timer.getTime()
   Game.correct = nil
   Game.countdown = nil               
   Game.direction = 0
   everLocked = nil
   startTime = love.timer.getTime()
   
   local card = cards.pop()
   Game.rhs = card.rhs
   Game.lhs = card.lhs
   
   Game.cardCounter = 10
end

function Choose:update(dt)
   Game.states.Play.update(self,dt)
   
   if directionMaximum < direction then
      directionMaximum = direction
   end

   if math.abs(direction) > 0.1 and not pressed then
      s = sign(direction)
      direction = (direction - s*0.5) * 0.9 + s*0.5
   else
      direction = direction * 0.95
   end
   
   if directionMaximum > 0 then
      Game.direction = direction / math.abs(directionMaximum)
   else
      Game.direction = direction
   end

   if math.abs(direction) > 0.15 then
      if (lockTime == nil) then
	 lockTime = love.timer.getTime()
	 if everLocked == nil then
	    everLocked = true
	    Game.power = Game.power + math.min( 0.15, math.max(0, startTime - lockTime) )
	 end
      end

      if (lockDirection == nil) then
	 lockDirection = direction
      end
      
      if (lockDirection * direction > 0) then
	 Game.countdown = love.timer.getTime() - lockTime
      else
	 lockTime = nil
	 Game.countdown = nil
	 lockDirection = nil	 
      end
   else
      lockTime = nil
      Game.countdown = nil      
   end

   if Game.countdown then
      if Game.countdown > 0.6 then
	 self:popState()
	 self:pushState('Check')
      end
   end
end

function Choose:keypressed(key, code)
   if key == 'left' or key == 'down' then
      direction = 0.5
      lockTime = nil
      Game.countdown = nil            
   end
   if key == 'right' or key == 'up' then
      direction = -0.5
      lockTime = nil
      Game.countdown = nil            
   end
   
   if key == 'escape' then
      self:popState()
      self:pushState("GameOver")      
   end   
end

function sign(x)
  return x>0 and 1 or x<0 and -1 or 0
end

function Choose:mousepressed(x, y, button, isTouch)
   lastTime = love.timer.getTime()
   direction = 0
   pressed = true
end

function Choose:mousereleased(x, y, button, isTouch)
   pressed = false
end

function Choose:mousemoved( x, y, dx, dy, istouch )
   if pressed then
      duration = love.timer.getTime() - lastTime

      if love.graphics.getWidth() < love.graphics.getHeight() then
	 direction = direction - mouseSpeed * dy / love.graphics.getHeight()
      else
	 direction = direction - mouseSpeed * dx / love.graphics.getWidth()	 
      end
      
      lastTime = love.timer.getTime()
   end
end
