levels = {
	{spawn = {
		{time = 20, func = function(room) room:addObject(text,gw,gh/2,{text = "Press UP or W to jump!", dx = -1}) end},
		{time = 90, func = function(room) room:addObject(block,180,0) end},
		{time = 100, func = function(room) room:addObject(coin,180,35) end}
	},
	winTime = 300},
	{spawn = {
		{time = 0, func = function(room) room:addObject(spike,180,0) end}
	},
	winTime = 600}
}

return levels