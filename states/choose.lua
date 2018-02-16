-- states/play.lua

local Choose = Game:addState('Choose')

local dots = require '../dots'

local direction = 0
local directionMaximum = 0
local lastTime
local pressed = false
local mouseSpeed = 2
local radius = 100
local lockTime = nil
local lockDirection = nil

function Choose:enteredState()
   direction = 0
   lastTime = love.timer.getTime()

   -- should also randomly choose a card
   
   width = love.graphics.getWidth( )
   font = love.graphics.newFont((width - radius) / 4 )
end

function Choose:update(dt)
  -- You should switch to another state here,
  -- Usually when a button is pressed.
   -- Either with gotoState() or pushState()
   
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

   if math.abs(direction) > 0.1 then
      if (lockTime == nil) then
	 lockTime = love.timer.getTime()
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
      if Game.countdown > 1 then
	 -- THIS IS WHERE I MOVE TO A "CHECK" STATE
	 self:popState()
	 self:pushState('Check')
      end
   end
end

function Choose:keypressed(key, code)
   if key == 'left' then
      direction = -0.5
      lockTime = nil
      Game.countdown = nil            
   end
   if key == 'right' then
      direction = 0.5
      lockTime = nil
      Game.countdown = nil            
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
      direction = direction + mouseSpeed * dx / love.graphics.getWidth()
      
      lastTime = love.timer.getTime()
   end
end
