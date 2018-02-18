all: middleclass.lua stateful.lua tween.lua

middleclass.lua: Makefile
	wget -c https://raw.githubusercontent.com/kikito/middleclass/master/middleclass.lua

stateful.lua: Makefile
	wget -c https://raw.githubusercontent.com/kikito/stateful.lua/master/stateful.lua

tween.lua: Makefile
	wget -c https://raw.githubusercontent.com/kikito/tween.lua/master/tween.lua

clean:
	rm -f middleclass.lua stateful.lua
