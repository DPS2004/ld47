spike = GameObject:extend()

-- this is a circle
function spike:new(...)
  spike.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = 0
  self.dx = -1
  self.x = self.x or 180
  -- todo move this elsewhere bc loading a sprite every time you create an object is not super good
  self.spr = love.graphics.newImage("assets/spr/spike.png")
  self.shape = {name = "spike"}
  self.world:add(self.shape, self.x, self.y, 7, 16)
end

function spike:update()
  self.x = self.x + self.dx
  self.world:update(self.shape, self.x, self.y)
end

function spike:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-82+self.y)
end

