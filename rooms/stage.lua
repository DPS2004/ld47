Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  self.world = bump.newWorld(32)

  self.maincirc = self:addObject(maincircle, gw/2, gh/2, {color = colors[3], mult = -1})
  self.player = self:addObject(player, gw/2, 0)
  self.portal = self:addObject(portal, 180, 0)
  self.block = self:addObject(block, 180, 0)
  self.spike = self:addObject(spike, 270, 0)
  music:play()
end

function Stage:update(dt)
  if self.dead then return end
  if maininput:pressed("back") then
    gotoRoom('Menu')
    return
  end
  if self.paused then return end
  Stage.super.update(self, dt)
  if not self.dead and not music:isPlaying() then
    music:seek(0)
    music:play()
  end
end

function Stage:pause()
  self.paused = true
end

function Stage:destroy()
  self.dead = true
  music:stop()
end

function Stage:draw()
  push:setCanvas("main")
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print(tostring(love.timer.getFPS()))


  push:setCanvas("background")
  love.graphics.clear(0, 0, 0, 1)
  love.graphics.push("all")
    love.graphics.translate(gw/2, gh/2)
    love.graphics.setLineWidth(10)
    love.graphics.setBlendMode("add")
    helpers.color(5)
    love.graphics.rotate((love.timer.getTime() - start_time) / 3)
    for i = 1, 7, 3 do
      local radius = math.mod(i * 20 + (love.timer.getTime() - start_time) * i * 10, 300)
      local radius_2 = 300 - math.mod(i * 20 + (love.timer.getTime() - start_time) * i * 8, 300)
      love.graphics.setLineWidth(math.min(i * 10 * math.sin(radius / 100), radius))
      love.graphics.circle('line', 0, 0, radius, 100)
      love.graphics.setLineWidth(math.min(i * 10 * math.sin(radius_2 / 100), radius_2))
      love.graphics.circle('line', 0, 0, radius_2, 100)
    end

  love.graphics.pop()
end