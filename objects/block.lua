block = GameObject:extend()

-- this is a circle
function block:new(...)
  block.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = 0
  self.dx = -1
  self.x = self.x or 180
  self.spr = love.graphics.newImage("assets/spr/block.png")
  
end

function block:update()
  self.x = self.x + self.dx
  
end

function block:draw()
  --love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,8,-82+self.y)

  --love.graphics.pop()
end

