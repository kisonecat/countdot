local M = {}
local dots = require 'dots'

local filenames

-- thanks to https://gist.github.com/Uradamus/10323382
function shuffle(tbl)
  size = #tbl
  for i = size, 1, -1 do
    local rand = math.random(size)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end

function M.load()
   filenames = love.filesystem.getDirectoryItems( 'cards' )
   filenames = shuffle(filenames)
end

function M.pop()
   if filenames == nil or #filenames == 0 then
      M.load()
   end
   
   local filename = string.gsub( table.remove(filenames), ".lua", "", 1 )
   circle = dots.circle
   grid = dots.grid
   return require('cards/' .. filename)
end

return M
