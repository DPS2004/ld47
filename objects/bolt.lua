bolt = GameObject:extend()

function bolt:new(...)
  bolt.super.new(self, ...)
  self.color = colors[1]
  self.width = self.width or 8
  self.dy = 0
  self.y = 0
  self.dx = self.dx or 0
  self.x = self.x or 0
  self.countdown = self.countdown or 120
  self.max_countdown = self.countdown
  self.emitter = love.graphics.newParticleSystem(particle, 1000)
  self.emitter:setParticleLifetime(2,2)
  self.emitter:setEmissionRate(60)
  self.emitter:setEmissionArea("normal",self.width/2,40)
  self.shape = {name = "bolt"}
end

function bolt:update(dt)
  if self.dead then return end
  bolt.super.update(self, dt)
  self.emitter:update(dt)

  self.x = self.x + self.dx
  local to_red = math.min(1, math.max(self.countdown/self.max_countdown, 0))
  self.emitter:setColors({1,to_red,to_red,1})
  self.countdown = self.countdown - 1
  if self.countdown == 3 then self.world:add(self.shape, self.x, self.y, self.width, 80) end
  if self.countdown < 3 then self.world:update(self.shape, self.x, self.y) end
  if self.countdown == 0 then self:kill() return end
end

function bolt:draw()
  love.graphics.draw(self.emitter,gw/2,gh/2,math.rad(0-self.x),1,1,0,-82+self.y)
  if self.countdown <= 3 then
  	love.graphics.push("all")
  	local transform = love.math.newTransform(gw/2,gh/2,math.rad(0-self.x),1,1,0,-100+self.y)
  	love.graphics.replaceTransform(transform)
  	local points = {
  		{math.rad(0-self.x+math.random(-2,2)),self.y-100},
  		{math.rad(0-self.x+math.random(-2,2)),self.y-80},
  		{math.rad(0-self.x+math.random(-2,2)),self.y-60},
  		{math.rad(0-self.x+math.random(-2,2)),self.y-40},
  		{math.rad(0-self.x+math.random(-2,2)),self.y-20},
  		{math.rad(0-self.x+math.random(-2,2)),self.y}
  	}
  	love.graphics.line(points[1][1],points[1][2],points[2][1],points[2][2],points[3][1],points[3][2],points[4][1],points[4][2],points[5][1],points[5][2],points[6][1],points[6][2])
  	love.graphics.pop()
  end
end