OptionBox = GameObject:extend()

function OptionBox:new(area, x, y, opts)
  OptionBox.super.new(self, area, x, y, opts)
  self.visual_width = 0
  self.visual_height = 0
  self.timer:tween(1, self, {visual_height = self.height, visual_width = self.width}, 'out-elastic', nil, nil, 1, 0.5)
  self.selected_index = self.selected_index or 1
  self.options = self.options or {
    {name="no options smh", type = "float", step = "0.1", value = 0.5, onSet = function(v) print(v) end}, 
    {name="add some options", type = "bool", value = false, onSet = function(v) print(tostring(v)) end}
  }
  self.padding = self.padding or 4
  self.line_spacing = self.line_spacing or 2
end


function OptionBox:update(dt)
  if self.dead then return end
  OptionBox.super.update(self, dt)

  -- update selection
  if maininput:pressed('up') then
    self.selected_index = self.selected_index - 1
  elseif maininput:pressed('down') then
    self.selected_index = self.selected_index + 1
  end
  self.selected_index = lume.clamp(self.selected_index, 1, #self.options)

  
  local opt = self.options[self.selected_index]
  if (opt.type == "bool" and -- process bool options
     (maininput:pressed("accept") or maininput:pressed("right") or maininput:pressed("left"))) then
    opt.value = not opt.value
    opt.onSet(opt.value)
  elseif (opt.type == "float") then -- process float options
    if (maininput:pressed("left"))  then
      opt.value = opt.value - opt.step
      opt.onSet(opt.value)
    elseif (maininput:pressed("right")) then
      opt.value = opt.value + opt.step
      opt.onSet(opt.value)
    end
    if math.abs(opt.value) < 0.00001 then
      opt.value = 0
    end
  elseif (opt.type == "function" and maininput:pressed("accept")) then -- process function options
    opt.func()
  end
end


function OptionBox:draw()
  love.graphics.setLineWidth(3)
  

  -- black background
  helpers.color(2)
  love.graphics.rectangle('fill', self.x - self.visual_width / 2, 
    self.y - self.visual_height / 2, 
    self.visual_width, self.visual_height)


  -- mask out the options behind the box
  love.graphics.stencil(function()
    love.graphics.rectangle('fill', self.x - self.visual_width / 2, 
    self.y - self.visual_height / 2, 
    self.visual_width, self.visual_height)
  end, 'increment')
  love.graphics.setStencilTest("greater", 0)
  
  -- options !!
  helpers.color(1)
  love.graphics.print("YEAH")
  local font = love.graphics.getFont()
  local next_option_height = 0
  for i, v in ipairs(self.options) do
      love.graphics.print(
        (i == self.selected_index and "> " or "  ") .. v.name,
        self.x + self.padding - self.width / 2,
        self.y + self.padding - self.height / 2 + next_option_height
      )
    if (v.type ~= "function") then
      love.graphics.print(tostring(v.value),
      self.x + self.width / 2 - self.padding - font:getWidth(tostring(v.value)),
      self.y - self.height / 2+ self.padding + next_option_height
    )
    end
    next_option_height = next_option_height + font:getHeight() + self.line_spacing
  end


  love.graphics.setStencilTest()
  helpers.color(3)
  love.graphics.rectangle('line', self.x - self.visual_width / 2, 
                                  self.y - self.visual_height / 2, 
                                  self.visual_width, self.visual_height)
end