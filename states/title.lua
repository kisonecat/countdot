-- states/title.lua

local Title = Game:addState('Title')
local tween = require '../lib/tween'

local titleText
local subtitleText 
local tweenings
local pulsates
local width
local height
local bigFont
local startButton

local pulsate = function ()
   -- t (time): starts in 0 and usually moves towards duration
   -- b (begin): initial value of the of the property being eased.
   -- c (change): ending value of the property - starting value of the property
   -- d (duration): total duration of the tween
   return function (t, b, c, d) return c * (1 - math.cos(2 * t * math.pi / d))/2 + b end
end

function Title:enteredState()
   -- these should all be in terms of a SQUARE coordinate system!
   
   -- should check to make sure that the screen is oriented in landscape
   height = love.graphics.getHeight( )
   width = love.graphics.getWidth( )
   
   bigFont = love.graphics.newFont( height/5 )
   smallFont = love.graphics.newFont( height/15 )   
   
   tweenings = {}
   pulsates = {}   
   
   titleText = { x=0,
		 y=height/3 - height/20,
		 text = "countdot",
		 color=255 }
   
   table.insert( tweenings, tween.new(3, titleText, {y=height/3}, 'outQuint') )
   table.insert( tweenings, tween.new(1, titleText, {color=0}, 'outQuint') )

   subtitleText = { x=0,
		    y=height/3 + bigFont:getHeight() + height/20,
		    text = "a game of inequalities",
		    color=255 }
   
   table.insert( tweenings,
		 tween.new(5,
			   subtitleText,
			   {y=height/3 + bigFont:getHeight()},
			   'outQuad') )
   table.insert( tweenings, tween.new(3, subtitleText, {color=150}, 'outQuad') )

   startButton = { x=0,
		   y=2*height/3,
		   width=150,
		   height=smallFont:getHeight(),
		   text = "Start",
		   color=50,
		   backgroundColor = 250 }

   startButton.x = (width - smallFont:getWidth(startButton.text))/2
   
   table.insert( pulsates, tween.new(2, startButton, {color=100}, pulsate()) )
   table.insert( pulsates, tween.new(2, startButton, {backgroundColor=240}, pulsate()) )   
end

function Title:update(dt)
  -- You should switch to another state here,
  -- Usually when a button is pressed.
   -- Either with gotoState() or pushState()

   for _,t in pairs(tweenings) do
      t:update(dt)
   end

   for _,t in pairs(pulsates) do
      if t:update(dt) then
	 t:reset()
      end
   end
end

function Title:draw()
   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )
   
   startButton.x = (width - startButton.width)/2
   startButton.y = 2*height/3
   
   -- Draw your title stuff (buttons, etc.) here
   love.graphics.setBackgroundColor(255,255,255)

   love.graphics.setColor(titleText.color, titleText.color, titleText.color )
   love.graphics.setFont(bigFont)   
   love.graphics.printf(titleText.text, titleText.x, titleText.y, width, 'center')

   love.graphics.setColor(subtitleText.color, subtitleText.color, subtitleText.color )
   love.graphics.setFont(smallFont)   
   love.graphics.printf(subtitleText.text, subtitleText.x, subtitleText.y, width, 'center')


   love.graphics.setFont(smallFont)
   love.graphics.setColor(startButton.backgroundColor, startButton.backgroundColor, startButton.backgroundColor )      
   love.graphics.rectangle( 'fill', startButton.x, startButton.y, startButton.width, startButton.height )
   love.graphics.setColor(0,0,0)
   love.graphics.rectangle( 'line', startButton.x, startButton.y, startButton.width, startButton.height )
   love.graphics.setColor(startButton.color, startButton.color, startButton.color )   
   love.graphics.printf(startButton.text, startButton.x, startButton.y, startButton.width, 'center')      
end

function Title:keypressed(key, code)
     -- Pause game
  if key == 'p' then
    self:pushState('Pause')
  end
end
