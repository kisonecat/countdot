-- the goal is a syntax permitting

-- grid(2,2) * circle(5)
-- circle(5) * grid(1,2)
-- (circle(5) - 1) * grid(2,2) - 1
-- (circle(5) - 1) * (grid(2,2) - 1)
-- also (grid(2,2) + 1) is permitted

local M = {}
local Card = {}

local function compose(a,b)
   return Card.new(
      {render=function(self, h)
	  return a:render( function() b:render(h) end )
      end
   })
end

local function skip(f, j)
   if (type(j) ~= "number") then
      j = j:count()
   end   
   
   return Card.new(
      {render=
	  function(self, h)
	     local i = 1
	     return f:render(
		function()
		   if (i > j) then
		      h()
		   end
		   i = i + 1
		end
	     )
	  end
   })
end

function M.dot()
   love.graphics.push()
   local lineWidth = 10
   love.graphics.setLineWidth( lineWidth )
   love.graphics.circle( 'fill', 0, 0, 50 - lineWidth/2 )
   love.graphics.circle( 'line', 0, 0, 50 - lineWidth/2 )   
   love.graphics.pop()
end

function M.todots(n)
   if     (n == 1) then return M.grid(1,1)
   elseif (n == 2) then return M.grid(2,1)
   elseif (n == 3) then return M.circle(3)
   elseif (n == 4) then return M.grid(2,2)
   elseif (n == 5) then return M.circle(5)
   elseif (n == 6) then return M.grid(3,2)
   elseif (n == 7) then return M.circle(7)
   elseif (n == 8) then return M.grid(4,2)
   elseif (n == 9) then return M.grid(3,3)
   elseif (n == 10) then return M.grid(5,2)
   else return M.circle(n)
   end
end

local function sum(f,g)
   if (type(g) == "number") then
      g = M.todots(g)
   end
   
   return Card.new(
      {render=function(self, h)
	  local i = 0
	  M.grid(2,1):render(
	     function()
		i = i + 1		
		if i == 1 then
		   return f:render(h)
		else
		   return g:render(h)
		end
	     end
			    )
      end
   })
end

local function stack(f,g)
   return Card.new(
      {render=function(self, h)
	  local i = 0
	  M.grid(1,2):render( function()
		i = i + 1		
		if i == 1 then
		   return f:render(h)
		else
		   return g:render(h)
		end
			      end
			  )
      end
   })
end

Card.prototype = {}
Card.mt = {
   __mul = compose,
   __add = sum,
   __concat = stack,
   __sub = skip
}

function Card.new (o)
   setmetatable(o, Card.mt)
   
   o.count = function(self)
      local i = 0
      o:render( function()
	    i = i + 1
      end)
      return i
   end
   
   return o
end

function M.grid(cx,cy)
   return Card.new(
      {render=function(self, f)
	  local count = math.max(cx,cy)
	  love.graphics.push()
	  love.graphics.scale( 1 / math.sqrt(2) )
	  for x = 0, cx - 1 do
	     for y = 0, cy - 1 do
		love.graphics.push()
		love.graphics.translate( (x - cx/2) * 100 / count,
		   (y - cy/2) * 100 / count )
		love.graphics.scale( 1 / count )
		love.graphics.translate( 50, 50 )
		love.graphics.scale( 0.9 )
		f()
		love.graphics.pop()	    
	     end      
	  end
	  love.graphics.pop()	          
      end
   })
end

-- deprecated
local function box()
   love.graphics.push()
   love.graphics.scale( 1 / math.sqrt(2) )
   love.graphics.rectangle('fill',-50,50,100,100)
   love.graphics.pop()	       
end

function M.circle(count)
   return Card.new(
      {render=function(self, f)   
	  for i = 1, count do
	     local angle = 2 * math.pi * i / count
	     local inner = 50 / (1 + 1 / math.sin (math.pi / count) )
	     local radius = 50 - inner
	     love.graphics.push()	 
	     love.graphics.translate( radius * math.cos(angle),
				      radius * math.sin(angle) )
	     love.graphics.rotate( 2 * math.pi * i / count )
	     love.graphics.scale( inner / 50 )
	     love.graphics.scale( 0.9 )
	     f()
	     love.graphics.pop()	 
	  end
      end
   })
end

return M
