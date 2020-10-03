Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  Stage.maincirc = self:addObject(maincircle, 0, 0, {color = colors[3], mult = -1})
  Stage.player = self:addObject(player, gw/2, 0)
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