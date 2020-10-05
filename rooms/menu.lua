Menu = Room:extend()

function Menu:new()
  self.super.new(self)
  love.graphics.setFont(game_font)
  self.last = 0
  self.color = {1,1,1,0}
  self.colors = {
    {{1,1,1,0}}, --default
    {{1,0,77/255,1},{1,163/255,0,1},{1,236/255,39/255,1},{0,228/255,54/255,1},{41/255,173/255,1,1},{131/255,118/255,156/255,1},{1,119/255,168/255,1}}, --dps
    {{72/255,72/255,92/255,1},{130/255,84/255,113/255,1},{1,69/255,0,1}}, --pipe
    {{124/255,30/255,1,1},{1,41/255,125/255,1}}, --katie
    {{1,0,0,1},{1,0.5,0,1},{1,1,0,1},{0,1,0,1},{0,0,1,1},{0.1,0,1,1},{1,0,1,1},{1,1,1,1}} --ds
  }
  self.focus = 1
  self.level = 1

  self.optionsMenu = self:addObject(OptionBox, gw/2, gh/2, {width = 120, height = 46, options = {
    {type = "float", name = "Play", step = "1", value = self.level, onSet = function(v)
        self.level = math.max(math.min(v, 30), 0)
        self.optionsMenu.options[1].value = self.level
      end,

      func =
      function() 
        level_playing = self.level
        gotoRoom('Stage')
      end
    },
    {type = "function", name = "Options", func = function()
    	self.optionsMenu:kill()
    	self:addObject(OptionBox, gw/2, gh/2, {width = 180, height = 75, options = {
    		{type = "float", name = "Endless Spawn Min Time (seconds):", step = "1", value = settings.spawnMin/60, onSet = function(v) settings.spawnMin = math.min(v*60, settings.spawnMax) end},
    		{type = "float", name = "Endless Spawn Max Time (seconds):", step = "1", value = settings.spawnMax/60, onSet = function(v) settings.spawnMax = math.max(v*60, settings.spawnMin) end},
    		{type = "float", name = "Decoration Density:", step = "1", value = settings.decorDens, onSet = function(v) settings.decorDens = math.min(math.max(v, 1), 100) end},
        {type = "float", name = "Master Volume", step = "10", value = settings.masterVolume*100, onSet = function(v) settings.masterVolume = v/100 end},
        {type = "float", name = "Music Volume", step = "10", value = settings.musicVolume*100, onSet = function(v) settings.musicVolume = v/100 end},
        {type = "float", name = "Sound Volume", step = "10", value = settings.soundVolume*100, onSet = function(v) settings.soundVolume = v/100 end},
    		{type = "function", name = "Back", func = function()
          love.audio.setVolume(settings.masterVolume)
          music:setVolume(settings.musicVolume)
          coinsnd:setVolume(settings.soundVolume)
          hurtsnd:setVolume(settings.soundVolume)
          self:new()
        end}
    	}})
    end},
    {type = "function", name = "Credits", func = function ()
      self.optionsMenu:kill()
      self:addObject(OptionBox, gw/2, gh/2, {width = 200, height = 66, options = {
        {type = "function", name = "DPS2004 - Coordinator, Lead Developer", func = function() self.focus = 2 end},
        {type = "function", name = "pipelinks - Programmer, Shader Expert", func = function() self.focus = 3 end},
        {type = "function", name = "Katie1118 - Lead Artist, Hypesquad", func = function() self.focus = 4 end},
        {type = "function", name = "DeadlySprinklez - Programmer, Artist", func = function() self.focus = 5 end},
        {type = "function", name = "", func = function() self.focus = 1 end},
        {type = "function", name = "Back", func = function() self:new() end}
      }, selected_index = 6})
    end},
    {type = "function", name = "Exit", func = function() love.event.quit() end},
  }})
end

function Menu:update(dt)
  self.timer:update(dt)
  Menu.super.update(self, dt)
  if self.last+0.5 < love.timer.getTime() then
    self.color = self.colors[self.focus][math.random(1,#self.colors[self.focus])]
    self.last = love.timer.getTime()
  end
end

function Menu:draw()
  push:setCanvas("main")
  self.super.draw(self)
  helpers.color(1)
  love.graphics.push("all")
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill",0,gh-18,gw,18,4)
  love.graphics.pop()
  helpers.color(2)
  love.graphics.print("Thanks for playing! Here's some colors chosen by the devs.", 26, gh-13)
end