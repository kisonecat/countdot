all: middleclass.lua stateful.lua

middleclass.lua: Makefile
	wget -c https://raw.githubusercontent.com/kikito/middleclass/master/middleclass.lua

stateful.lua: Makefile
	wget -c https://raw.githubusercontent.com/kikito/stateful.lua/master/stateful.lua

clean:
	rm -f middleclass.lua stateful.lua
