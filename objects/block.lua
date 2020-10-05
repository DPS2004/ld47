block = GameObject:extend()

-- this is a circle
-- no it's not
function block:new(...)
  block.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = self.y or 0
  self.dx = -1
  self.x = self.x or 180
  self.spr = blocksprite
  
  self.shape = { name = "block" }
  self.world:add(self.shape, self.x, self.y, self.width, self.height)
end

function block:update()
  if self.dead then return end
  self.x = self.x + self.dx
  local _, _, cols = self.world:move(self.shape, self.x, self.y, function() return "cross" end)
  -- what
  for _, col in ipairs(cols) do
    if col.other.name == "player" then
      self.world:update(col.other, col.otherRect.x + self.dx, col.otherRect.y)
    end
  end
  if self.x < -180 then self:kill() end
end

function block:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-82+self.y)
end

