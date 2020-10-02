Rectangle = GameObject:extend()

-- this is actually a circle
function Rectangle:new(...)
  Rectangle.super.new(self, ...)
  self.color = self.color or {1, 1, 1, 1}
  self.mult = self.mult or 1
  self.width = self.width or 32
  self.height = self.height or 32
end

function Rectangle:update()
  local mx, my = push:toGame(love.mouse.getPosition())
  self.x = (mx - gw / 2) * self.mult + gw/2
  self.y = (my - gh / 2) * self.mult + gh/2
end

function Rectangle:draw()
  love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.x,self.y,self.width/2)
  love.graphics.pop()
end

