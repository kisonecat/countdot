-- the goal is a syntax permitting

-- grid(2,2) * circle(5)
-- circle(5) * grid(1,2)
-- (circle(5) - 1) * grid(2,2) - 1
-- (circle(5) - 1) * (grid(2,2) - 1)
-- also (grid(2,2) + 1) is permitted

function compose(a,b)
   return Card.new(
      {render=function(h)
	  return a.render( function() b.render(h) end )
      end
   })
end

function sum(f,g)
   return Card.new(
      {render=function(h)
	  grid(2,1).render( function(i)
		if i == 1 then
		   return f.render(h)
		else
		   return g.render(h)
		end
			    end
			  )
      end
   })
end

function stack(f,g)
   return Card.new(
      {render=function(h)
	  grid(1,2).render( function(i)
		if i == 1 then
		   return f.render(h)
		else
		   return g.render(h)
		end
			    end
			  )
      end
   })
end

-- remove the first "count" things from this
function skip(f, count)
   return function(dot, i)
      if (i > j) then
	 dot(dot,i - j)
      end
   end
end

Card = {}
Card.prototype = {}
Card.mt = {
   __mul = compose,
   __add = sum,
   __div = stack,
   __sub = skip
}

function Card.new (o)
   setmetatable(o, Card.mt)
   return o
end

function grid(cx,cy)
   return Card.new(
      {render=function(f)
	  local count = math.max(cx,cy)
	  local i = 1
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
		f(i)
		i = i + 1
		love.graphics.pop()	    
	     end      
	  end
	  love.graphics.pop()	          
      end
   })
end



function dot()
   love.graphics.push()
   local lineWidth = 10
   love.graphics.setLineWidth( lineWidth )
   love.graphics.circle( 'fill', 0, 0, 50 - lineWidth/2 )
   love.graphics.circle( 'line', 0, 0, 50 - lineWidth/2 )   
   love.graphics.pop()
end

function box()
   love.graphics.push()
   love.graphics.scale( 1 / math.sqrt(2) )
   love.graphics.rectangle('fill',-50,50,100,100)
   love.graphics.pop()	       
end



function circle(count)
   return Card.new(
      {render=function(f)   
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
	     f(i)
	     love.graphics.pop()	 
	  end
      end
   })
end

