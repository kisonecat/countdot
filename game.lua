--- game.lua

Game = class('Game'):include(Stateful)

require 'states/menu'
require 'states/title'
require 'states/about'
require 'states/play'
require 'states/pause'
require 'states/choose'
require 'states/check'
require 'states/gameover'

function Game:initialize()
   Game.fontSans = love.graphics.newImageFont( 'fonts/sffamily-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789,.!?:;' )
   Game.fontSerif = love.graphics.newImageFont( 'fonts/computer-modern.png', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789,.!?:;' )   
   Game.soundWrong = love.audio.newSource("sounds/Downer01.wav", "static")
   Game.soundCorrect = love.audio.newSource("sounds/Coin01.wav", "static")

   Game.musicEnding = love.audio.newSource("music/Juhani Junkala [Retro Game Music Pack] Ending.mp3")
   Game.musicLevel1 = love.audio.newSource("music/Juhani Junkala [Retro Game Music Pack] Level 1.mp3")
   Game.musicLevel2 = love.audio.newSource("music/Juhani Junkala [Retro Game Music Pack] Level 2.mp3")
   Game.musicLevel3 = love.audio.newSource("music/Juhani Junkala [Retro Game Music Pack] Level 3.mp3")
   Game.musicTitle = love.audio.newSource("music/Juhani Junkala [Retro Game Music Pack] Title Screen.mp3")
   
   self:gotoState('Title')
end

function Game:exit()
end

function Game:update(dt)
end

function Game:draw()
end

function Game:keypressed(key, code)
  -- Pause game
  if key == 'p' then
    self:pushState('Pause')
  end
end

function Game:mousepressed(x, y, button, isTouch)
end

function Game:mousereleased(x, y, button, isTouch)
end

function Game:mousemoved( x, y, dx, dy, istouch )
end
