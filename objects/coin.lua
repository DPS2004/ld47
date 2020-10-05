coin = GameObject:extend()

function coin:new(...)
  coin.super.new(self, ...)
  self.color = colors[1]
  self.width = 8
  self.height = 8
  self.dy = 0
  self.y = self.y or 0
  self.dx = -1
  self.x = self.x or 180
  self.spr = coinsprite
  
  self.shape = { name = "coin" }
  self.world:add(self.shape, self.x, self.y, self.width, self.height)
end

function coin:update()
  if self.dead then return end
  self.x = self.x + self.dx
  self.world:update(self.shape, self.x, self.y)
  if self.x < -180 then self:kill() end
end

function coin:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-82+self.y)
end