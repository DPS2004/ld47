Menu = Room:extend()

function Menu:new()
  self.super.new(self)
  love.graphics.setFont(game_font)
  self.emitter = love.graphics.newParticleSystem(particle, 100)
  self.emitter:setDirection(math.rad(90))
  self.emitter:setSpread(math.rad(45))
  self.emitter:setSpeed(5,10)
  self.emitter:setLinearDamping(0,1)
  self.emitter:setParticleLifetime(5,5)

  self.optionsMenu = self:addObject(OptionBox, gw/2, gh/2, {width = 120, height = 46, options = {
    {type = "function", name = "Play", func = function() gotoRoom('Stage') end},
    {type = "function", name = "Options", func = function()
    	self.optionsMenu:kill()
    	self:addObject(OptionBox, gw/2, gh/2, {width = 180, height = 45, options = {
    		{type = "float", name = "Endless Spawn Min Time (seconds):", step = "1", value = settings.spawnMin/60, onSet = function(v) settings.spawnMin = math.min(v*60, settings.spawnMax) end},
    		{type = "float", name = "Endless Spawn Max Time (seconds):", step = "1", value = settings.spawnMax/60, onSet = function(v) settings.spawnMax = math.max(v*60, settings.spawnMin) end},
    		{type = "float", name = "Decoration Density:", step = "1", value = settings.decorDens, onSet = function(v) settings.decorDens = math.min(math.max(v, 1), 100) end},
    		{type = "function", name = "Back", func = function() self:new() end}
    	}})
    end},
    {type = "function", name = "Credits", func = function ()
      self.optionsMenu:kill()
      self:addObject(OptionBox, gw/2, gh/2, {width = 200, height = 66, options = {
        {type = "function", name = "DPS2004 - Coordinator, Lead Developer", func = function() end},
        {type = "function", name = "pipelinks - Programmer, Shader Expert", func = function() end},
        {type = "function", name = "Katie1118 - Lead Artist, Hypesquad", func = function() end},
        {type = "function", name = "DeadlySprinklez - Programmer, Artist", func = function() 
          self.emitter:setColors({1,0,0,1}, {1,0.5,0,1}, {1,1,0,1}, {0,1,0,1}, {0,0,1,0}, {0.1,0,1,1}, {1,0,1,1}, {1,1,1,1})
          self.emitter:start()
        end},
        {type = "function", name = ("" or (emitter:isActive() and "Stop Particles")), func = function() self.emitter:stop() end},
        {type = "function", name = "Back", func = function() self:new() end}
      }, selected_index = 6})
    end},
    {type = "function", name = "Exit", func = function() love.event.quit() end},
  }})
  self.emitter:setPosition(self.optionsMenu.x + self.optionsMenu.padding - self.optionsMenu.width / 2, gh/2)
end

function Menu:update(dt)
  self.super.update(dt)
  self.emitter:update(dt)
end

function Menu:draw()
  self.super.draw(self)
  helpers.color(1)
end