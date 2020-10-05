player = GameObject:extend()

-- this is a circle
function player:new(...)
  maincircle.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = 0
  self.old_y = 0
  self.dx = 0
  self.x = 0
  self.hp = 3
  self.safety = 0
  self.spr = ez.newanim(ez.newtemplate("assets/spr/runanimtemp.png",16,3,true))
  self.shape = {name="player"}
  self.draw_priority = 50
  self.world:add(self.shape, self.x, self.y, 8, self.height)
end

function player:update()
  ez.animupdate(self.spr,1)
  self.old_y = self.y
  if self.hp == 0 then
    gotoRoom('Menu')
  end
  
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


  
  if self.safety ~= 0 then self.safety = self.safety - 1 end

  if maininput:pressed("up") and self.old_y == self.y then
    self.dy = 3.3
  end

  if math.abs(self.dx) <= 0.05 then
    self.dx = 0
  end
  
  if self.x > 120 or self.x < -120 then
    if self.safety == 0 then
      self.hp = self.hp - 1
    end
    self.safety = 240
    self.x = 0
    self.dx = 0
    self.y = 0
    self.dy = 0
    self.world:move(self.shape, self.x, self.y, function() return "cross" end)
    return
  end

  -- yoo collision stuffff
  local filter = function(item, other) 
    if other.name == "spike" then
      return "cross"
    end
    if other.name == "block" then
      return "slide"
    end
  end
  print(self.x)
  local real_x, real_y, cols = self.world:move(self.shape, self.x, self.y, filter)
  self.x = real_x
  self.y = real_y
  for i, col in pairs(cols) do
    print(col.other.name, col.normal.x, col.normal.y)
    if col.other.name == "coin" then
      self.room.score = self.room.score + 10
    end
    if self.safety == 0 and col.other.name == "spike" then
      self.hp = self.hp - 1
      self.safety = 180
    end
  end
end

function player:draw()
  --love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  if self.safety % 4 < 3 or self.safety == 0 then
    ez.animdraw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-80+self.y)
  end
  love.graphics.print("X: "..tostring(self.x)..
    "\nDelta X: "..tostring(self.dx)..
    "\nY: "..tostring(self.y)..
    "\nOld Y: "..tostring(self.old_y)..
    "\nCan Jump: "..tostring(self.old_y == self.y)..
    "\nDelta Y: "..tostring(self.dy)..
    "\nHP: "..tostring(self.hp)..
    "\nInvuln.: "..tostring(math.floor(self.safety/6)/10),0,40)
  --love.graphics.pop()
end

