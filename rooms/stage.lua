Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  self.world = bump.newWorld(32)

  self.maincirc = self:addObject(maincircle, gw/2, gh/2, {color = colors[3], mult = -1})
  self.frames = 0
  self.score = 0
  self.player = self:addObject(player, gw/2, 0)
  self.portal = self:addObject(portal, 180, 0)
  self.block = self:addObject(block, 180, 0)
  self.spike = self:addObject(spike, 270, 0)
  music:play()
end

function Stage:update(dt)
  if self.dead then return end
  self.frames = self.frames + 1
  if self.frames%60 == 0 then
    self.frames = 0
    self.score = self.score + 1
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
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print(tostring(love.timer.getFPS()))
end