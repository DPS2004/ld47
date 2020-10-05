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
bump = require 'lib/bump'

require 'utils'
-- for pixels to look pixelly
love.graphics.setLineStyle('rough')
love.graphics.setDefaultFilter('nearest','nearest')
game_font = love.graphics.newFont('assets/04b03.ttf',8)
game_font:setFilter('nearest')
love.graphics.setFont(game_font)
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
      left = {"key:left", "key:a", "axis:leftx-", "button:dpleft"},
      right = {"key:right", "key:d", "axis:leftx+", "button:dpright"},
      up = {"key:up", "key:w", "axis:lefty-", "button:dpup"},
      down = {"key:down", "key:s", "axis:lefty+", "button:dpdown"},
      accept = {"key:space", "button:a"},
      back = {"key:escape", "button:b"},
      reload = {"key:r"},
      draw_collision = {"key:t"},
    },
    pairs = {
      lr = {"left", "right", "up", "down"}
    },
      joystick = love.joystick.getJoysticks()[1],
  }

  cs = nil

  blocksprite = love.graphics.newImage("assets/spr/block.png")
  spikesprite = love.graphics.newImage("assets/spr/spike.png")
  coinsprite = love.graphics.newImage("assets/spr/coin.png")
  bushsprite = love.graphics.newImage("assets/spr/bush.png")
  lampsprite = love.graphics.newImage("assets/spr/lamppost.png")
  music = love.audio.newSource("assets/audio/ld47.ogg", "static")
  coinsnd = love.audio.newSource("assets/audio/coin.ogg", "static")
  hurtsnd = love.audio.newSource("assets/audio/dmg.ogg", "static")

  gotoRoom('Menu')



  -- do push stuff
  push:setupScreen(gw, gh, gw*sx, gh*sy, {pixelperfect = true})
  push:setupCanvas({
    { name = 'main' },
  })
  settings = {}
  settings.spawnMin = 300
  settings.spawnMax = 600
  settings.decorDens = 10

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
  if maininput:pressed("draw_collision") then
    draw_collision = not draw_collision
  end
  next_time = next_time + min_dt
end

function love.draw()
  push:start()
  shack:apply()
  cs:draw()

  if draw_collision then
    love.graphics.push("all")
    love.graphics.translate(gw/2, gh/2 + 100)
    love.graphics.scale(-1, 1)
    love.graphics.rotate(math.pi)
    love.graphics.setLineWidth(1)
    if cs.world then
      for i, v in ipairs(cs.world:getItems()) do
        love.graphics.setColor(1, 0, 0, 0.7)
        love.graphics.rectangle('fill', cs.world:getRect(v))
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.rectangle('line', cs.world:getRect(v))
        --print(inspect{cs.world:getRect(v)}, inspect(v))
      end
    end
    love.graphics.pop()
  end

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
