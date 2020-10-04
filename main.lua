--require all the Cool Libraries that we're never gonna use
Object = require 'lib/classic'
Input = require 'lib/boipushy'
Timer = require 'lib/chrono'
Camera = require 'lib/camera'
baton = require 'lib/baton'
moses = require 'lib/moses'
ez = require 'lib/ezanim'
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
      reload = {"key:r"},
    },
    pairs = {
      lr = {"left", "right", "up", "down"}
    },
      joystick = love.joystick.getJoysticks()[1],
  }

  cs = nil

  gotoRoom('Menu')



  -- do push stuff
  push:setupScreen(gw, gh, gw*sx, gh*sy, {pixelperfect = true})
  push:setupCanvas({
    { name = 'main' },
  })

  -- shack can be used for screen shakes and stuff whoaaa
  shack:setDimensions(gw, gh)

  min_dt = 1/60
  next_time = love.timer.getTime()
end

function love.update(dt)
  maininput:update()
  cs:update(dt)
  lovebird.update()
  if maininput:pressed("reload") then
    lurker.scan()
  end
  next_time = next_time + min_dt
end

function love.draw()
  push:start()
  shack:apply()
  cs:draw()
  push:finish()
  local cur_time = love.timer.getTime()
  if next_time <= cur_time then
    next_time = cur_time
    next_time = cur_time
    return
  end
  love.timer.sleep(next_time - cur_time)
end

function gotoRoom(room_type, ...)
  if cs and cs.destroy then
    cs:destroy()
  end
  cs = _G[room_type](...)
end
