-- states/title.lua

local About = Game:addState('About')
local camera = require 'camera'
local tween = require 'lib/tween'
local tweenings
local aboutText

function About:enteredState()
   -- these should all be in terms of a SQUARE coordinate system!
   sans = love.graphics.newImageFont( 'fonts/sffamily-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789' )
   serif = love.graphics.newImageFont( 'fonts/computer-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789' )

   tweenings = {}
   aboutText = { x=0,
		 y=23,
		 height=8,
		 width=100,
		 text = "created by Jim Fowler",
		 opacity=0 }

   table.insert( tweenings, tween.new(3, aboutText, {opacity=255}, 'outQuint') )
end

function About:update(dt)
   for _,t in pairs(tweenings) do
      t:update(dt)
   end   
end

function About:draw()
   love.graphics.setBackgroundColor(255,255,255)

   camera.apply()
   local scale = camera.getScale()

   love.graphics.setColor(0,0,0, aboutText.opacity)   
   love.graphics.setFont(sans)
   local s = aboutText.height / sans:getHeight()
   love.graphics.print(aboutText.text, aboutText.x + aboutText.width/2 - s*sans:getWidth(aboutText.text)/2, aboutText.y, 0, s, s )
		       
end

function About:mousepressed(x, y, button, isTouch)
   self:gotoState('Title')
end

function About:keypressed(key, code)
   self:gotoState('Title')
end
