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
  self.spr = love.graphics.newImage("assets/spr/spike.png")
  
end

function spike:update()
  self.x = self.x + self.dx
  
end

function spike:draw()
  --love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,4,-82+self.y)

  --love.graphics.pop()
end

