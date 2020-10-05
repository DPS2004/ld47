gw = 384 -- window sizeeee
gh = 216
sx = 2 -- window scaleeee
sy = sx

function love.conf(t)
  t.window.title = "Ludum Dare 47"
  t.window.width = gw 
  t.window.height = gh
  t.console = false
end
