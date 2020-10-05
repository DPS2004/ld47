--todo make a base class for this u dumb
Room = Object:extend()

function Room:new()
  self.timer = Timer() -- timer is used for tweens
	self.game_objects = {}
end



function Room:update(dt)
	-- update gameobjects, remove ones with .dead = true
	for i = #self.game_objects, 1, -1 do
    local game_object = self.game_objects[i]
		if game_object.dead then table.remove(self.game_objects, i) end
    deep.queue(game_object.update_priority, function() game_object:update(dt) end)
	end
	
	-- update the timerrrrr
	self.timer:update(dt)
	deep.execute()
end

function Room:draw()
	-- draw the
	love.graphics.clear()
	for _, game_object in ipairs(self.game_objects) do 
		deep.queue(game_object.draw_priority, function() game_object:draw() end)
	end
	deep.execute()
end

function Room:destroy()
	-- can overload this if you need to do something when the room closes
end


-- what do you think this does
function Room:addObject(game_object_type, x, y, opts)
  local opts = opts or {}
  local game_object = game_object_type(self, x or 0, y or 0, opts)
  table.insert(self.game_objects, game_object)
  return game_object
end