Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  self.world = bump.newWorld(32)

  self.maincirc = self:addObject(maincircle, gw/2, gh/2, {color = colors[3], mult = -1})
  self.player = self:addObject(player, gw/2, 0)
  self.block = self:addObject(block, 180, 0)
  self.spike = self:addObject(spike, 270, 0)

end

function Stage:update(dt)
  if maininput:pressed("back") then
    gotoRoom('Menu')
  end
  if self.paused then return end
  Stage.super.update(self, dt)
end

function Stage:pause()
  self.paused = true
end
function Stage:draw()
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print(tostring(love.timer.getFPS()))
end