--require all the Cool Libraries that we're never gonna use
Object = require 'lib/classic'
Input = require 'lib/boipushy'
Timer = require 'lib/chrono'
Camera = require 'lib/camera'
moses = require 'lib/moses'
lurker = require 'lib/lurker'
lume = require 'lib/lume'
push = require 'lib/push'
inspect = require 'lib/inspect'
shack = require 'lib/shack'
deep = require 'lib/deep'

require 'utils'

-- require() all the objects and rooms files yeah
require 'classrequire'
obj_list = {}
recursiveEnumerate('objects', obj_list)
recursiveEnumerate('rooms', obj_list)
requireFiles(obj_list)

function love.load()
  input = Input()
  camera = Camera()

  --keybinds for resizing the window
  input:bind('1', function() resize(1) end)
  input:bind('2', function() resize(2) end)
  input:bind('3', function() resize(3) end)
  input:bind('4', function() resize(4) end)
  input:bind('5', function() resize(5) end)
  input:bind('r', lurker.scan)

  -- keybind to hot reload code and reload the main room
  input:bind('f5', function() lurker.scan() gotoRoom('Stage') end)

  current_room = nil

  gotoRoom('Stage')

  -- for pixels to look pixelly
  love.graphics.setLineStyle('rough')
  love.graphics.setDefaultFilter('nearest')

  -- do push stuff
  push:setupScreen(gw, gh, gw*sx, gh*sy, {pixelperfect = true})
  push:setupCanvas({
    { name = 'main' },
  })

  -- shack can be used for screen shakes and stuff whoaaa
  shack:setDimensions(gw, gh)
end

function love.update(dt)
  current_room:update(dt)
end

function love.draw()
  push:start()
  shack:apply()
  current_room:draw()
  push:finish()
end

function gotoRoom(room_type, ...)
  if current_room and current_room.destroy then
    current_room:destroy()
  end
  current_room = _G[room_type](...)
end
