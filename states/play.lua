-- states/play.lua

local Play = Game:addState('Play')

local dots = require '../dots'

local radius = 100

local font

function Play:enteredState()
   lastTime = love.timer.getTime()

   Game.lhs = (dots.circle(5) - 1) * (dots.circle(5) - 1) - 1
   Game.rhs = (dots.circle(4) * (dots.grid(3,3) + 1))
   
   width = love.graphics.getWidth( )
   font = love.graphics.newFont((width - radius) / 4 )

   self:pushState('Choose')
end

function Play:update(dt)
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

function Play:draw()
   -- Draw your play stuff (buttons, etc.) here
   love.graphics.setBackgroundColor(255,255,255)
   
   --love.graphics.setColor(0, 0, 51, 100)
   --love.graphics.rectangle('fill', 350, 200, 200, 50)
   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )

   thickness = width / 50

   -- BADBAD: check to see if the scale 
   -- and make sure that there is enough space for the HUD

   love.graphics.setColor(0,0,0)
   
   -- draw left hand card
   love.graphics.origin()
   
   love.graphics.translate( (width/2 - radius/2)/2, height/2 )
   love.graphics.scale( (width/2 - radius/2) / 100 )
   love.graphics.scale( 0.9 )
   -- love.graphics.circle( 'fill', 0, 0, 100 )
   -- grid( 2, 5, dot )()
   -- grid( 3, 3, grid(2,2,box) )()
   --love.graphics.setColor(255,0,0)
   --dot()
   --love.graphics.setColor(0,0,0)
   -- grid(1,2)( function() grid(5,5)(dot) end )
   -- compose( grid(1,2), grid(5,5) )(dot)
   -- compose( circle(7), grid(2,1) )(dot)
   
   --dot()
   -- circular( 6, grid(3,3,circular(5,dot)) )()
   -- grid(5,2,dot)()
   -- circle(5)( function() circle(4)(dot) end )
   local card = Game.lhs
   card:render(dots.dot)
   -- circular( 5, circular( 5, grid(3,3,box) ) )()

   -- draw right hand card
   love.graphics.origin()
   
   love.graphics.translate( width - (width/4 - radius/4), height/2 )
   love.graphics.scale( (width - radius) / 100.0 / 2 )
   love.graphics.scale( 0.9 )
   --circle(4, function(i) if i > 2 then return circle(5, dot) end end )()
   -- circle(4, function(i) if i ~= 1 then circle(5, dot)() end end )()
   --circle(4, skip(1, circle(5,dot)))()
   -- circle(4, circle(5, skip(2)))(dot)
   --circle(4)( circle(5) (dot) )
   -- stack( sum( grid(2,2), circle(4) ), sum( circle(5), circle(7) ) )(dot)
   --circle(4,circle(5)) (dot)
   -- local card = circle(3) + circle(3)
   local card = Game.rhs
   card:render(dots.dot)
	  
   -- Also try drawing numbers
   -- but should try to handle the case where the text is too tall too
   love.graphics.origin()
   love.graphics.translate( width - (width/4 - radius/4), height/2 )
   love.graphics.setColor(255,0,0)
   love.graphics.setFont(font)

   --if (Game.countdown) then
   --text = tostring( math.floor(Game.countdown) )
   --love.graphics.print(text, -font:getWidth(text)/2, -font:getHeight()/2 )
   --end
   
   -- draw inequality symbol
   love.graphics.origin()

   s = sign(Game.direction)
   
   love.graphics.translate( width/2, height/2 )

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
