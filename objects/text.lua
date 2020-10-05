text = GameObject:extend()

function text:new(...)
  text.super.new(self, ...)
  self.color = colors[1]
  self.dy = 0
  self.y = self.y or 0
  self.dx = self.dx or -1
  self.x = self.x or 180
  self.text = self.text or "no text, idiot"
end

function text:update()
  if self.dead then return end
  self.x = self.x + self.dx
  if self.x < -500 then self:kill() end
end

function text:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.print(self.text, self.x, self.y)
end