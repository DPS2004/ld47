portal = GameObject:extend()

function portal:new(...)
  portal.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.dy = 0
  self.y = 0
  self.dx = 0
  self.x = 180
  self.rng = settings.spawnMax
  self.total_time = 0
  self.last_decoration = 10
  self.objectRNG = 0
  self.spr = blocksprite
end

function portal:update()
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

function portal:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.print(self.rng..
    "\n"..self.objectRNG,0,20)
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-82+self.y)
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