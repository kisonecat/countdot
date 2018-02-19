-- states/play.lua

local Check = Game:addState('Check')

function Check:enteredState()
   local lhs
   local rhs
   
   if type(Game.lhs) == "number" then
      lhs = Game.lhs
   else
      lhs = Game.lhs:count()
   end

   if type(Game.rhs) == "number" then
      rhs = Game.rhs
   else
      rhs = Game.rhs:count()
   end
   
   if (lhs > rhs) then
      Game.correct = (Game.direction < 0)
   elseif (lhs < rhs) then
      Game.correct = (Game.direction > 0)
   else
      Game.correct = false      
   end

   if Game.correct then
      Game.soundCorrect:play()
      if (Game.cardCounter > 0) then
	 Game.power = Game.power + Game.cardCounter
      end
      Game.score = Game.score + math.max(100, math.floor(100*Game.cardCounter))
   else
      Game.soundWrong:play()
   end
end

function Check:update(dt)
   Game.states.Play.update(self,dt)

   -- maybe wait a bit here to fade out or whatever
   self:popState()
   self:pushState('Choose')   
end

