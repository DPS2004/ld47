-- some random stuff here idk don't care

function resize(s)
  sx, sy = s, s
  love.window.setMode(s*gw, s*gh)
  push:resize(gw * sx, gh * sy);
end

function random(min, max)
  local min, max = min or 0, max or 1
  return (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)
end

function HSL(h, s, l)
  if s == 0 then return l, l, l end
  local function to(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < .16667 then return p + (q - p) * 6 * t end
    if t < .5 then return q end
    if t < .66667 then return p + (q - p) * (.66667 - t) * 6 end
    return p
  end
  local q = l < .5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return to(p, q, h + .33334), to(p, q, h), to(p, q, h - .33334)
end

function starts_with(str, start)
  return str:sub(1, #start) == start
end

function ends_with(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

function map_number(x, a1, b1, a2, b2)
  return (x - a1) / (b1 - a1) * (b2 - a2) + a2
end

function hexColor(hex)
	return {
    tonumber(string.sub(hex, 1, 2), 16)/256,
    tonumber(string.sub(hex, 3, 4), 16)/256,
    tonumber(string.sub(hex, 5, 6), 16)/256, 1
  }
end