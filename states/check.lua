-- states/play.lua

local Check = Game:addState('Check')

function Check:enteredState()

   local lhs = Game.lhs:count()
   local rhs = Game.rhs:count()

   if (lhs > rhs) and (direction > 0) then
   end
end

function Check:update(dt)
end

