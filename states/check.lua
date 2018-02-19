-- states/play.lua

local Check = Game:addState('Check')
local tween = require '../lib/tween'

local tweening

function Check:enteredState()
   local lhs
   local rhs

   Game.fade = 255
   tweening = tween.new(0.35, Game, {fade=0}, 'outQuint')
      
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
   table.remove(Game.corrects, 1)

   denominator = 0
   numerator = 0
   for _,c in pairs(Game.corrects) do
      denominator = denominator + 1
      if c then
	 numerator = numerator + 1
      end
   end
   Game.ratio = numerator / denominator

   if (Game.correct) then
      if (Game.cardCounter > 0) then
	 Game.power = Game.power + Game.cardCounter * math.pow(Game.ratio,3)
	 if (Game.power > Game.maxPower) then
	    Game.power = Game.maxPower
	 end
      end

      Game.score = Game.score + 1
      Game.score = Game.score + math.floor(math.max(100, math.floor(100*Game.cardCounter)) * math.pow(Game.ratio,2))
   end

end

function Check:update(dt)
   Game.states.Play.update(self,dt)

   if (tweening:update(dt)) then
      self:popState()
      self:pushState('Choose')
   end
end

