Area = Object:extend()

function Area:new(room)
  self.room = room
  self.game_objects = {}
end

function Area:update(dt)
  for i = #self.game_objects, 1, -1 do
    local game_object = self.game_objects[i]
    game_object:update(dt)
    if game_object.dead then table.remove(self.game_objects, i) end
  end
end

function Area:draw()
  for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function Area:addObject(game_object_type, x, y, opts)
  local opts = opts or {}
  local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
  table.insert(self.game_objects, game_object)
  return game_object
end

function Area:createObject(game_object_type, x, y, opts)
  local opts = opts or {}
  local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
  return game_object
end

function Area:addExistingObject(game_object)
  table.insert(self.game_objects, game_object)
end

-- Returns all objects that meet a condition
function Area:getObjects(cond)
  return cond and tables.select(self.game_objects, cond) or self.game_objects
end

-- Performs a function on all objects in a list
function Area:doWithObjects(func, obj)
  local obj = obj or self.game_objects
  for _, v in pairs(obj) do
    func(v)
  end
end

-- Performs a function on all objects that meet a condition
function Area:doWithObjectsIf(func, cond)
  for _, v in pairs(Area:getObjects(cond)) do
    func(v)
  end
end

-- Returns all objects in a circular area
function Area:queryCircleArea(center_x, center_y, radius, cond)
  local obj = {}
  for _, v in pairs(self:getObjects(cond)) do
    if (v.x - center_x)^2 + (v.y - center_y)^2 <= radius^2 then
      table.insert(obj, v)
    end
  end
  return obj
end


