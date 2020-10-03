player = GameObject:extend()

-- this is a circle
function player:new(...)
  maincircle.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.y = 0
  self.dx = 0
  self.x = 0
  self.spr = love.graphics.newImage("assets/spr/player.png")
  
end

function player:update()
  
  if maininput:down("left") then
    if self.dx > 0 then
      self.dx = self.dx - 0.20
    else
      self.dx = self.dx - 0.15
    end
  end
  if maininput:down("right") then
    if self.dx < 0 then
      self.dx = self.dx + 0.20
    else
      self.dx = self.dx + 0.15
    end
  end
  if self.dx >= 5 then
    self.dx = 5
  end
  if self.dx <= -5 then
    self.dx = -5
    
  end
  
  self.x = self.x +self.dx
  if self.dx > 0 then
    self.dx = self.dx - 0.05
  end
  if self.dx < 0 then
    self.dx = self.dx + 0.05
  end

  if self.x > 45 then
    self.x = 45
    self.dx = 0
  elseif self.x < -45 then
    self.x = - 45
    self.dx = 0
  end

  if math.abs(self.dx) <= 0.05 then
    self.dx = 0
  end
end

function player:draw()
  --love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,9,-80+self.y)
  --love.graphics.pop()
end

