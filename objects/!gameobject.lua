-- base gameobject yeahhhhhhhhhhh
-- the ! in front of the name is so that it would get require()d before everything else
-- which feels kinda spaghetti to me but i also don't care

GameObject = Object:extend()

function GameObject:new(room, x, y, opts)
  local opts = opts or {}
  if opts then for k, v in pairs(opts) do self[k] = v end end

  self.room = room
  self.x, self.y = x, y
  self.dead = false
  self.timer = Timer()
  self.draw_priority = 0
  self.update_priority = 0
  self.world = room.world
end

function GameObject:update(dt)
  if self.timer then self.timer:update(dt) end
end

function GameObject:draw()

end

function GameObject:kill()
  self.dead = true
  if self.shape then
    self.world:remove(self.shape)
  end
end