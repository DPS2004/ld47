Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  -- testy rectangle whoaa
  self:addObject(Rectangle, 0, 0)
  local second_rect = self:addObject(Rectangle, 0, 0, {color = {1, 0, 0, 1}, mult = -1})
  second_rect.draw_priority = -1
end


function Stage:draw()
  self.super.draw(self)
  
  love.graphics.print("test text!!!")
  
  
end