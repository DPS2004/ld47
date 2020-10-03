--require all the Cool Libraries that we're never gonna use
Object = require 'lib/classic'
Input = require 'lib/boipushy'
Timer = require 'lib/chrono'
Camera = require 'lib/camera'
baton = require 'lib/baton'
moses = require 'lib/moses'
lovebird = require 'lib/lovebird'
lurker = require 'lib/lurker'
helpers = require 'lib/helpers'
colors = {{1,1,1},{0,0,0},{255/255,33/255,232/255},{178/255,0,255/255},{33/255,0,127/255}}
lume = require 'lib/lume'
push = require 'lib/push'
inspect = require 'lib/inspect'
shack = require 'lib/shack'
deep = require 'lib/deep'

require 'utils'
-- for pixels to look pixelly
love.graphics.setLineStyle('rough')
love.graphics.setDefaultFilter('nearest','nearest')
local font = love.graphics.newFont('assets/04b03.ttf',8)
font:setFilter('nearest')
love.graphics.setFont(font)
-- require() all the objects and rooms files yeah
require 'classrequire'
obj_list = {}
recursiveEnumerate('objects', obj_list)
recursiveEnumerate('rooms', obj_list)
requireFiles(obj_list)

function love.load()
  input = Input()
  camera = Camera()
  maininput = baton.new {
    controls = {
      left = {"key:left",  "axis:leftx-", "button:dpleft"},
      right = {"key:right",  "axis:leftx+", "button:dpright"},
      up = {"key:up", "key:w", "axis:lefty-", "button:dpup"},
      down = {"key:down", "key:s", "axis:lefty+", "button:dpdown"},
      accept = {"key:space", "button:a"},
      back = {"key:escape", "button:b"},
    },
    pairs = {
      lr = {"left", "right", "up", "down"}
    },
      joystick = love.joystick.getJoysticks()[1],
  }
  --keybinds for resizing the window
  input:bind('1', function() resize(1) end)
  input:bind('2', function() resize(2) end)
  input:bind('3', function() resize(3) end)
  input:bind('4', function() resize(4) end)
  input:bind('5', function() resize(5) end)
  input:bind('r', lurker.scan)

  -- keybind to hot reload code and reload the main room
  input:bind('f5', function() lurker.scan() gotoRoom('Stage') end)

  cs = nil

  gotoRoom('Stage')



  -- do push stuff
  push:setupScreen(gw, gh, gw*sx, gh*sy, {pixelperfect = true})
  push:setupCanvas({
    { name = 'main' },
  })

  -- shack can be used for screen shakes and stuff whoaaa
  shack:setDimensions(gw, gh)
end

function love.update(dt)
  maininput:update()
  cs:update(dt)
  lovebird.update()
end

function love.draw()
  push:start()
  shack:apply()
  cs:draw()
  push:finish()
end

function gotoRoom(room_type, ...)
  if cs and cs.destroy then
    cs:destroy()
  end
  cs = _G[room_type](...)
end
