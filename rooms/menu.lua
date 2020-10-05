Menu = Room:extend()

function Menu:new()
  self.super.new(self)
  love.graphics.setFont(game_font)

  self.optionsMenu = self:addObject(OptionBox, gw/2, gh/2, {width = 120, height = 36, options = {
    {type = "function", name = "Play", func = function() gotoRoom('Stage') end},
    {type = "function", name = "Options", func = function()
    	self.optionsMenu:kill()
    	self:addObject(OptionBox, gw/2, gh/2, {width = 180, height = 48, options = {
    		{type = "float", name = "Endless Spawn Min Time (seconds):", step = "1", value = settings.spawnMin/60, onSet = function(v) settings.spawnMin = math.min(v*60, settings.spawnMax) end},
    		{type = "float", name = "Endless Spawn Max Time (seconds):", step = "1", value = settings.spawnMax/60, onSet = function(v) settings.spawnMax = math.max(v*60, settings.spawnMin) end},
    		{type = "float", name = "Decoration Density:", step = "1", value = settings.decorDens, onSet = function(v) settings.decorDens = math.min(math.max(v, 1), 100) end},
    		{type = "function", name = "Back", func = function() self:new() end}
    	}})
    end},
    {type = "function", name = "Exit", func = function() love.event.quit() end},
  }})
end 

function Menu:draw()
  self.super.draw(self)
  helpers.color(1)
  love.graphics.print("welcome to the\nM A I N  M E N U")
end