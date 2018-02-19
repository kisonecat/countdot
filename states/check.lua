-- states/play.lua

local Check = Game:addState('Check')
local tween = require '../lib/tween'

local tweening

function Check:enteredState()
   local lhs
   local rhs

   Game.fade = 0
   tweening = tween.new(0.35, Game, {fade=255}, 'outQuint')
      
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
      Game.soundCorrect:rewind()            
      Game.soundCorrect:play()
      Game.countCorrect = Game.countCorrect + 1
   else
      Game.soundWrong:rewind()                  
      Game.soundWrong:play()
      Game.countWrong = Game.countWrong + 1
   end   
   
   table.insert(Game.corrects, Game.correct)
   while (#(Game.corrects) > 10) do
      table.remove(Game.corrects, 1)
   end

   denominator = 0
   numerator = 0
   for _,c in pairs(Game.corrects) do
      denominator = denominator + 1
      if c then
	 numerator = numerator + 1
      end
   end
   ratio = numerator / denominator

   if (Game.correct) then
      if (ratio > 0.70) then
	 if (Game.cardCounter > 0) then
	    Game.power = Game.power + Game.cardCounter
	    if (Game.power > 100) then
	       Game.power = 100
	    end
	 end
      end

      Game.score = Game.score + 1
      if (ratio > 0.5) then
	 Game.score = Game.score + math.floor(math.max(100, math.floor(100*Game.cardCounter)) * (ratio - 0.5))
      end
   end

end

function Check:update(dt)
   Game.states.Play.update(self,dt)

   if (tweening:update(dt)) then
      self:popState()
      self:pushState('Choose')
   end
end

