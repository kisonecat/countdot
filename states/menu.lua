-- states/menu.lua

local Menu = Game:addState('Menu')

function Menu:enteredState()
end

function Menu:update(dt)
  -- You should switch to another state here,
  -- Usually when a button is pressed.
  -- Either with gotoState() or pushState()
end

function Menu:draw()
   -- Draw your menu stuff (buttons, etc.) here
   --love.graphics.setBackgroundColor(BG_COLOR)

   love.graphics.setColor(0, 0, 51, 100)
   love.graphics.rectangle('fill', 350, 200, 200, 50)
   
   love.graphics.setColor(255, 223, 0)
   love.graphics.printf('MENU', 350, 220, 200, 'center')
end

function Menu:keypressed(key, code)
     -- Pause game
  if key == 'p' then
    self:pushState('Pause')
  end
end
