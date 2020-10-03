Stage = Room:extend()

function Stage:new()
  self.super.new(self) -- call base room constructor oh yeahhhhhhhh

  -- testy rectangle whoaa
  
  --self:addObject(Rectangle, 0, 0,{color = colors[4], mult = 1})
  --local second_rect = self:addObject(Rectangle, 0, 0, {color = colors[3], mult = -1})
  --second_rect.draw_priority = -1
  --print(obj_list)
  Stage.maincirc = self:addObject(maincircle, 0, 0, {color = colors[3], mult = -1})
  Stage.player = self:addObject(player, gw/2, 200)
end


function Stage:draw()
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print("test text!!!")
  
  
end