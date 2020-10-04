player = GameObject:extend()

-- this is a circle
function player:new(...)
  maincircle.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = 0
  self.dx = 0
  self.x = 0
  self.spr = ez.newanim(ez.newtemplate("assets/spr/runanimtemp.png",16,3,true))
  
end

function player:update()
  
  if maininput:down("left") then
    if self.dx > 0 then
      self.dx = self.dx - 0.35
    else
      self.dx = self.dx - 0.30
    end
  end
  if maininput:down("right") then
    if self.dx < 0 then
      self.dx = self.dx + 0.35
    else
      self.dx = self.dx + 0.30
    end
  end
  if maininput:pressed("up") and self.y < 3 then
    self.dy = 3.33
  end
  if self.dx >= 5 then
    self.dx = 5
  end
  if self.dx <= -5 then
    self.dx = -5
    
  end
  
  self.x = self.x + self.dx
  self.y = self.y + self.dy
  if self.dx > 0 then
    self.dx = self.dx - 0.05
  end
  if self.dx < 0 then
    self.dx = self.dx + 0.05
  end
  if self.dy > -5 then
    self.dy = self.dy - 0.1
  end

  if self.x > 30 then
    self.dx = self.dx - 0.05
  elseif self.x < -30 then
    self.dx = self.dx + 0.05
  end
  if self.x > 0 then
    self.x = self.x /1.1
  elseif self.x < 0 then
    self.x = self.x/1.1
  end
  if self.y > 85 then
    self.dy = -1
  elseif self.y > 0 then
    self.y = self.y-0.5 /1.01
  else 
    self.y = 0
  end

  if math.abs(self.dx) <= 0.05 then
    self.dx = 0
  end
  ez.animupdate(self.spr,1)
end

function player:draw()
  --love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  ez.animdraw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,9,-80+self.y)
  love.graphics.print(tostring(self.y),0,40)
  --love.graphics.pop()
end

