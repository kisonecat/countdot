-- states/play.lua

local Play = Game:addState('Play')

local dots = require '../dots'

local radius = 15

local camera = require 'camera'

function Play:enteredState()
   lastTime = love.timer.getTime()

   width = love.graphics.getWidth( )

   Game.score = 0
   Game.level = 1
   Game.power = 10
   
   self:pushState('Choose')
end

function Play:update(dt)
   Game.power = Game.power - dt
   Game.cardCounter = Game.cardCounter - dt   

   if Game.power < 0 then
      Game.power = 0
      self:popState()
      self:pushState("GameOver")
   end
   
   -- check to see if game is over
end

function Play:keypressed(key, code)
   -- Quickly exit the game
  if key == 'escape' then
     love.event.quit()
  end  
end

function sign(x)
  return x>0 and 1 or x<0 and -1 or 0
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function Play:draw()
   love.graphics.setBackgroundColor(255,255,255)
   local font = Game.fontSans

   local height = love.graphics.getHeight( )
   local width = love.graphics.getWidth( )   
   
   love.graphics.origin()
   love.graphics.setFont(font)
   love.graphics.setColor(0,0,0,100)
   
   local s = height / 20 / font:getHeight()
   love.graphics.print("Score " .. comma_value(Game.score),0,0,0,s,s)
   --local level = "Level " .. tostring(Game.level)
   --love.graphics.print(level,width/2 - font:getWidth(level)*s/2,0,0,s,s)
   local power = "Power "
   local powerWidth = width/10
   love.graphics.print(power,width - font:getWidth(power)*s - powerWidth,0,0,s,s)
   -- draw this blinking if low on power

   if Game.power < 10 then
      local t = love.timer.getTime() % 1
      local c = 128 * (math.cos(t*math.pi*2) + 1)/2
      love.graphics.setColor(c,c,c,100)
   end
      
   love.graphics.rectangle('fill', width - powerWidth, 0, powerWidth * Game.power / 100, height/20 )
   
   camera.apply()
   love.graphics.setColor(0,0,0)

   -- draw left hand card
   love.graphics.origin()
   camera.apply()
   love.graphics.translate(50,50)   
   love.graphics.scale(0.5)
   love.graphics.translate(-50,0)
   love.graphics.scale(0.82)
   
   local card = Game.lhs
   if type(card) == "number" then
      local s = 50 / font:getHeight()
      love.graphics.print(tostring(card),-font:getWidth(tostring(card))*s/2,-25,0,s)
   else
      card:render(dots.dot)      
   end

   -- draw right hand card
   love.graphics.origin()
   camera.apply()
   love.graphics.translate(50,50)   
   love.graphics.scale(0.5)
   love.graphics.translate(50,0)   
   love.graphics.scale(0.82)
   
   local card = Game.rhs
   if type(card) == "number" then
      love.graphics.print(tostring(card),-font:getWidth(tostring(card))*s/2,-25,0,s)      
   else
      card:render(dots.dot)      
   end
	  
   -- Also try drawing numbers
   -- but should try to handle the case where the text is too tall too
   love.graphics.origin()
   love.graphics.translate( width - (width/4 - radius/4), height/2 )
   love.graphics.setColor(255,0,0)
   --love.graphics.setFont(font)
   
   -- draw inequality symbol
   love.graphics.origin()
   camera.apply()
   love.graphics.translate(50,50)   
   love.graphics.scale(0.5)
   
   s = sign(Game.direction)

   if Game.countdown then
      love.graphics.scale(  1.0 / (1 + 0.1*math.exp(-5*Game.countdown)) )
   else
      love.graphics.scale(  1.0 / (1 + 0.1) )
   end

   local brightness = 255 - (255 * 1.0 / (1 + 3*1))
   
   if (Game.countdown) then
      brightness = 255 - (255 * 1.0 / (1 + 3*math.exp(-5*Game.countdown)))
   end
   
   love.graphics.setColor(brightness,brightness,brightness)
   
   love.graphics.translate( - radius * s / 2, 0 )
   
   angle = math.abs(Game.direction)
   
   if angle > 0.5 then
      angle = 0.5
   end
   
   local thickness = 2
   lowerBound = math.asin(thickness / radius / 2)
   
   if angle > lowerBound then
      love.graphics.setLineWidth(thickness)
      love.graphics.setLineJoin('bevel')      
      love.graphics.line(
	 s*radius*math.cos(angle),
	 radius*math.sin(angle), 0, 0,
	 s*radius*math.cos(angle),
	    -radius*math.sin(angle) )
   end
   
end

function Play:mousepressed(x, y, button, isTouch)
end

function Play:mousereleased(x, y, button, isTouch)
end

function Play:mousemoved( x, y, dx, dy, istouch )
end
