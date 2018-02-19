local M = {}
local scale = 1
   
function M.apply()
   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )
   
   scale = 1
   love.graphics.origin()
   
   if (height < width) then
      love.graphics.translate( (width - height)/2, 0 )
      love.graphics.scale( height / 100 )
      scale = height / 100
   else
      love.graphics.translate(width/2, height/2)
      love.graphics.rotate(3*math.pi/2)
      love.graphics.translate(-width/2, -height/2)      

      love.graphics.translate( 0, (height - width)/2 )
      love.graphics.scale( width / 100 )
      scale = width / 100
   end
end

function M.getScale()
   return scale
end

function M.toWorld(x,y)
   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )
   
   if (height < width) then
      x = x - (width - height)/2
      x = x * 100/height
      y = y * 100/height
   else
      y = height - (height - width)/2 - y
      x,y = y,x
      x = x * 100/width
      y = y * 100/width
   end

   return x,y
end

return M
