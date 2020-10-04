Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  Stage.maincirc = self:addObject(maincircle, gw/2, gh/2, {color = colors[3], mult = -1})
  Stage.player = self:addObject(player, gw/2, 0)
  Stage.block = self:addObject(block, -180, 0)
  Stage.spike = self:addObject(spike, -270, 0)
end

function Stage:update(dt)
  Stage.super.update(self, dt)
  if maininput:pressed("back") then
    gotoRoom('Menu')
  end
end

function Stage:draw()
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print(tostring(love.timer.getFPS()))
  
  
end