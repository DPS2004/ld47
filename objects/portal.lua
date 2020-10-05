portal = GameObject:extend()

function portal:new(...)
  portal.super.new(self, ...)
  self.color = colors[1]
  self.width = 32
  self.height = 32
  self.dy = 0
  self.y = 0
  self.dx = 0
  self.x = 180
  self.list = self.list or nil
  if self.list then self.level = levels[self.list] end
  self.rng = settings.spawnMax
  self.total_time = 0
  self.last_decoration = 10
  self.objectRNG = 0
  self.spr = portalsprite
end

function portal:update()
  if self.list ~= nil then self:levelUpdate() return end
  -- at start, spawn random decorations
  if self.total_time == 0 then
    local i = 0
    while (i <= settings.decorDens) do
      i = i + 1
      if math.random(0,100)/100 < 0.5 then self.room:addObject(bush,self.x-(i*360/settings.decorDens),0,{time = 30})
      else self.room:addObject(lamppost,self.x-(i*360/settings.decorDens),0,{time = 30}) end
    end
  end
  self.total_time = love.timer.getTime()
  -- obstacle spawning
  if maininput:down("accept") and (maininput:pressed("up") or
    maininput:pressed("down") or maininput:pressed("left") or maininput:pressed("right")) then
    if maininput:pressed("up") then self:fmDoubleBlock() end
    if maininput:pressed("down") then self:fmSpikeBlock() end
    if maininput:pressed("right") then self:fmHoleInWall() end
    if maininput:pressed("left") then self.room:addObject(block,self.x,0) end
  end
  if self.rng <= 0 then
  	self.rng = math.random(settings.spawnMin, settings.spawnMax) -- set RNG spawn time to a number between 5 and 10
  	local objectY = math.random(0,6)*10
  	self.objectRNG = math.random(0,100)/100
  	if objectY > 44 and objectY < 60 then objectY = 60 end
  	if self.objectRNG > 0.75 then
  	  self:fmHoleInWall()
  	elseif self.objectRNG > 0.5 then
  	  self:fmSpikeBlock()
  	elseif self.objectRNG > 0.25 then
  	  self:fmDoubleBlock()
  	else
  	  self.room:addObject(spike,self.x,0)
  	  if self.objectRNG < 0.1 then self.room:addObject(spike,self.x+8,0) end
  	end
  end
  self.rng = self.rng - 1

  -- decoration spawning
  if self.total_time-self.last_decoration > 10/settings.decorDens or maininput:pressed("down") then
    self.last_decoration = self.total_time
    if math.random(0,100)/100 < 0.5 then self.room:addObject(bush,math.random(self.x-5,self.x+5),0)
    else self.room:addObject(lamppost,math.random(self.x-5,self.x+5),0) end
  end
end

function portal:levelUpdate()
  local i = 1
  local room = self.room
  while i <= #self.level.spawn do
    if self.level.spawn[i].time == self.total_time then
      self.level.spawn[i].func(room)
    end
    i = i + 1
  end
  self.total_time = self.total_time + 1
  if self.total_time > self.level.winTime then 
    if self.room.score > highscores[level_playing] then highscores[level_playing] = self.room.score end
    self.room.win = true
    if self.total_time > self.level.winTime + 300 then
      gotoRoom('Menu')
      return
    end
  end
end

function portal:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.print(self.rng..
    "\n"..self.objectRNG,0,20)
  love.graphics.draw(self.spr,gw/2,gh/2-90,math.rad(love.timer.getTime()*100),1,1,12,12)
end

function portal:fmSpikeBlock()
	self.room:addObject(block,self.x,0)
	self.room:addObject(spike,self.x,16)
end

function portal:fmDoubleBlock()
	self.room:addObject(block,self.x,0)
	self.room:addObject(block,self.x,16)
end

function portal:fmHoleInWall()
	self.room:addObject(block,self.x,0)
	self.room:addObject(block,self.x,50)
end