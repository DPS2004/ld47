player = GameObject:extend()

-- this is a circle
function player:new(...)
  maincircle.super.new(self, ...)
  self.color = colors[1]
  self.width = 16
  self.height = 16
  self.spr = love.graphics.newImage("assets/spr/player.png")
end

function player:update()
  local mx, my = push:toGame(love.mouse.getPosition())
  
end

function player:draw()
print("draw player")
  love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.draw(self.spr,self.x,self.y,0,1,1,9,12)
  love.graphics.pop()
end

