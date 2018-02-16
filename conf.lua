function love.conf(t)
   t.accelerometerjoystick = false      -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
   t.externalstorage = false           -- True to save files (and read from the save directory) in external storage on Android (boolean) 
   t.gammacorrect = false              -- Enable gamma-correct rendering, when supported by the system (boolean)
   
   t.window.title = "countdot"         -- The window title (string)
   t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)
   t.window.width = 800                -- The window width (number)
   t.window.height = 600               -- The window height (number)
   t.window.borderless = false         -- Remove all border visuals from the window (boolean)
   t.window.resizable = true           -- Let the window be user-resizable (boolean)
   t.window.minwidth = 100             -- Minimum window width if the window is resizable (number)
   t.window.minheight = 100            -- Minimum window height if the window is resizable (number)
   t.window.fullscreen = false         -- Enable fullscreen (boolean)
   t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
   t.window.vsync = true               -- Enable vertical sync (boolean)
   
   t.modules.physics = false           -- Enable the physics module (boolean)
end
