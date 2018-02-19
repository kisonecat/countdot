-- states/title.lua

local Title = Game:addState('Title')
local tween = require '../lib/tween'
local camera = require 'camera'

local titleText
local subtitleText
local bylineText
local tweenings
local pulsates
local width
local height
local bigFont
local startButton
local buttons

local pulsate = function ()
   -- t (time): starts in 0 and usually moves towards duration
   -- b (begin): initial value of the of the property being eased.
   -- c (change): ending value of the property - starting value of the property
   -- d (duration): total duration of the tween
   return function (t, b, c, d) return c * (1 - math.cos(2 * t * math.pi / d))/2 + b end
end

function Title:exitedState()
   Game.musicTitle:stop()
end

function Title:enteredState()
   Game.musicTitle:setLooping(true)
   Game.musicTitle:setVolume(0.22)
   Game.musicTitle:play()

   sans = love.graphics.newImageFont( 'fonts/sffamily-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789' )
   serif = love.graphics.newImageFont( 'fonts/computer-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789' )
   
   tweenings = {}
   pulsates = {}   
   
   titleText = { x=0,
		 y=23,
		 height=22,
		 width=100,
		 text = "countdot",
		 opacity=0 }
   
   table.insert( tweenings, tween.new(3, titleText, {y=26}, 'outQuint') )
   table.insert( tweenings, tween.new(1, titleText, {opacity=255}, 'outQuint') )

   subtitleText = { x=0,
		    y=46,
		    width=100,
		    text = "a game of inequalities",
		    opacity=0 }

   subtitleText.height = titleText.height * sans:getWidth(titleText.text) /  sans:getHeight() / (sans:getWidth(subtitleText.text) / sans:getHeight())

   bylineText = { x=0,
		  y=46 + subtitleText.height,
		  height=subtitleText.height/2,
		  width=100,
		  text = "by Jim Fowler",
		  opacity=0 }

   table.insert( tweenings, tween.new(5, subtitleText, {opacity=75}, 'outQuad') )
   table.insert( tweenings, tween.new(7, bylineText, {opacity=75}, 'outQuad') )   

   startButton = { x=50-15,
		   y=75,
		   width=30,
		   height=7,
		   text = "Start",
		   opacity=0,
		   color=255,
		   onclick=function()
		      self:gotoState('Play')		      
		   end
   }
   table.insert( tweenings, tween.new(2, startButton, {opacity=255}, 'outQuad') )   

   aboutButton = { x=100-25-startButton.x,
		   y=75,
		   width=25,
		   height=7,
		   text = "About",
		   opacity=0,
		   color=255,
		   onclick=function()
		      self:gotoState('About')		      
		   end		   
   }
   table.insert( tweenings, tween.new(2, aboutButton, {opacity=255}, 'outQuad') )      
   
   buttons = {}
   table.insert( buttons, startButton )
   --table.insert( buttons, aboutButton )
   
   -- startButton.x = (width - smallFont:getWidth(startButton.text))/2
   
   --table.insert( pulsates, tween.new(2, startButton, {color=100}, pulsate()) )
   --table.insert( pulsates, tween.new(2, startButton, {backgroundColor=240}, pulsate()) )   
end

function Title:update(dt)
   for _,t in pairs(tweenings) do
      t:update(dt)
   end

   for _,button in pairs(buttons) do
      if button.animation then
	 button.animation:update(dt)
      end
   end
end

function Title:draw()
   love.graphics.setBackgroundColor(255,255,255)

   camera.apply()
   local scale = camera.getScale()
   
   love.graphics.setColor(0,0,0, titleText.opacity)   
   love.graphics.setFont(sans)
   local s = titleText.height / sans:getHeight()
   love.graphics.print(titleText.text, titleText.x + titleText.width/2 - s*sans:getWidth(titleText.text)/2, titleText.y, 0, s, s )

   love.graphics.setColor(0,0,0, subtitleText.opacity)
   love.graphics.setFont(serif)
   local s = subtitleText.height / serif:getHeight()
   love.graphics.print(subtitleText.text, subtitleText.x + subtitleText.width/2 - s*serif:getWidth(subtitleText.text)/2, subtitleText.y, 0, s, s )

   love.graphics.setColor(0,0,0, bylineText.opacity)
   love.graphics.setFont(serif)
   local s = bylineText.height / serif:getHeight()
   love.graphics.print(bylineText.text, bylineText.x + bylineText.width/2 - s*serif:getWidth(bylineText.text)/2, bylineText.y, 0, s, s )

   local button = startButton

   for _,button in pairs(buttons) do
      love.graphics.setFont(sans)
      love.graphics.setColor(button.color,button.color,button.color,button.opacity)
      love.graphics.rectangle( 'fill', button.x, button.y, button.width, button.height )
      love.graphics.setColor(255-button.color,255-button.color,255-button.color, button.opacity)   
      love.graphics.setLineWidth(0.05)
      love.graphics.rectangle( 'line', button.x, button.y, button.width, button.height )
      local s = button.height / sans:getHeight()   
      love.graphics.print(button.text,
			  button.x + button.width/2 - s*sans:getWidth(button.text)/2,
			  button.y + button.height/2 - 0.8*s*sans:getHeight()/2,
			  0, s, s )   
   end
   
   return

end

function Title:mousepressed(x, y, button, isTouch)
   x,y = camera.toWorld(x,y)
   
   for _,button in pairs(buttons) do
      if (x >= button.x) and (y >= button.y) and (x <= button.x + button.width) and (y <= button.y + button.height) then
	 button.onclick()
      end
   end
end

function Title:mousemoved( x, y, dx, dy, istouch )
   x,y = camera.toWorld(x,y)
   
   for _,button in pairs(buttons) do
      if (x >= button.x) and (y >= button.y) and (x <= button.x + button.width) and (y <= button.y + button.height) then
	 button.animation = tween.new(0.5, button, {color=0}, 'outQuint')
      else
	 button.animation = tween.new(0.5, button, {color=255}, 'outQuint')
      end
   end
end

function Title:keypressed(key, code)
     -- Pause game
  if key == 'p' then
    self:pushState('Pause')
  end
end
