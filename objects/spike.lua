spike = GameObject:extend()

-- this is a circle
function spike:new(...)
  spike.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = self.y or 0
  self.dx = -1
  self.scale = 0
  self.x = self.x or 180
  -- todo move this elsewhere bc loading a sprite every time you create an object is not super good
  self.spr = spikesprite
  self.shape = {name = "spike"}
  self.world:add(self.shape, self.x, self.y, 7, 16)
end

function spike:update()
  if self.dead then return end
  self.x = self.x + self.dx
  self.world:update(self.shape, self.x, self.y)
  if self.x < -180 then self:kill() end
  if self.x <= -160 then self.scale = self.scale - 0.05 end
  if self.x >= 170 and self.x <= 180 then self.scale = self.scale + 0.1 end
end

function spike:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),self.scale,1,0,-82+self.y)
end

