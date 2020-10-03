maincircle = GameObject:extend()

-- this is a circle
function maincircle:new(...)
  maincircle.super.new(self, ...)
  self.color = self.color or colors[3]
  self.mult = self.mult or 1
  self.width = self.width or 200
  self.height = self.height or 32
end

function maincircle:update()
  local mx, my = push:toGame(love.mouse.getPosition())
  self.x = gw/2
  self.y = gh/2
end

function maincircle:draw()

  love.graphics.push("all")
  love.graphics.setLineWidth(5)
  love.graphics.setColor(self.color)
  love.graphics.circle('line', self.x,self.y,self.width/2)
  love.graphics.pop()
end

