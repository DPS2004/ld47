bush = GameObject:extend()

function bush:new(...)
	bush.super.new(self, ...)
	self.color = colors[1]
	self.width = 16
	self.height = 16
	self.dy = 0
	self.y = 0
	self.dx = -1
  self.scale = 0
	self.x = self.x or 180
	self.time = self.time or 0
	self.direction = math.random(0,1)
	if self.direction == 0 then self.direction = -1 end
	self.draw_priority = -1
	self.spr = bushsprite
end

function bush:update()
  if self.dead then return end
  if self.time < 30 then
  	self.time = self.time + 1
  	local _,l = self.world:querySegment(self.x-5,self.y-4,self.x+5,self.y+4)
  	if l > 0 then self.x = self.x + self.direction*10 end
  end
  self.x = self.x + self.dx
  if self.x < -180 then self:kill() end
  if self.x <= -160 then self.scale = self.scale - 0.05 end
  if self.x >= 170 and self.x <= 180 then self.scale = self.scale + 0.1 end
  if self.x < 170 and self.x > -160 then
    self.scale = 1
  end
end

function bush:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),self.scale,1,0,-82+self.y)
end