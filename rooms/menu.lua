Menu = Room:extend()

function Menu:new()
  self.super.new(self)
  love.graphics.setFont(game_font)

  self:addObject(OptionBox, gw/2, gh/2, {width = 120, height = 36, options = {
    {type = "function", name = "Play", func = function() gotoRoom('Stage') end},
    {type = "function", name = "Options", func = function() print('yeah') end},
    {type = "function", name = "Exit", func = function() love.event.quit() end},
  }})
end 

function Menu:draw()
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print("welcome to the\nM A I N  M E N U")
end