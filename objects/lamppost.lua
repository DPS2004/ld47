lamppost = GameObject:extend()

function lamppost:new(...)
	lamppost.super.new(self, ...)
	self.color = colors[1]
	self.width = 9
	self.height = 24
	self.dy = 0
	self.y = 0
	self.dx = -1
	self.x = self.x or 180
	self.time = self.time or 0
	self.direction = math.random(0,1)
	if self.direction == 0 then self.direction = -1 end
	self.draw_priority = -1
	self.spr = lampsprite
end

function lamppost:update()
  if self.dead then return end
  if self.time < 30 then
  	self.time = self.time + 1
  	local _,l = self.world:querySegment(self.x-5,self.y-4,self.x+5,self.y+4)
  	if l > 0 then self.x = self.x + self.direction*10 end
  end
  self.x = self.x + self.dx
  if self.x < -180 then self:kill() end
end

function lamppost:draw()
  love.graphics.setColor(self.color)
  love.graphics.setDefaultFilter('nearest','nearest')
  love.graphics.draw(self.spr,gw/2,gh/2,math.rad(0-self.x),1,1,0,-74+self.y)
end