levels = {
	-- level 1
	{spawn = {
		{time = 20, func = function(room) room:addObject(text,gw,gh/2,{text = "Press UP or W to jump!", dx = -1}) end},
		{time = 90, func = function(room) room:addObject(block,180,0) end},
		{time = 100, func = function(room) room:addObject(coin,180,35) end}
	},
	winTime = 300},
	-- level 2
	{spawn = {
		{time = 0, func = function(room) room:addObject(text,gw,gh/2,{text = "Spikes deal damage! Leap over them!"}) end},
		{time = 60, func = function(room) room:addObject(spike,180,0) end},
		{time = 180, func = function(room) room:addObject(spike,180,0) end},
		{time = 190, func = function(room) room:addObject(spike,180,0) end},
		{time = 240, func = function(room) room:addObject(spike,180,0) end},
		{time = 250, func = function(room) room:addObject(spike,180,0) end},
		{time = 250, func = function(room) room:addObject(coin,180,40) end},
		{time = 260, func = function(room) room:addObject(spike,180,0) end},
	},
	winTime = 460},
	-- level 3
	{spawn = {
		{time = 0, func = function(room) room:addObject(text,gw,gh/2,{text = "Spikes can stack on blocks!"}) end},
		{time = 0, func = function(room) room:addObject(text,gw,gh/2+13,{text = "Be sure to time your jumps!"}) end},
		{time = 60, func = function(room) room:addObject(spike,182,16) end},
		{time = 60, func = function(room) room:addObject(block,180,0) end},
		{time = 60, func = function(room) room:addObject(coin,180,40) end},
		{time = 120, func = function(room) room:addObject(spike,182,16) end},
		{time = 120, func = function(room) room:addObject(block,180,0) end},
		{time = 180, func = function(room) room:addObject(spike,182,16) end},
		{time = 180, func = function(room) room:addObject(block,180,0) end},
	},
	winTime = 380},
	-- level 4
	{spawn = {
		{time = 0, func = function(room) room:addObject(text,gw,gh/2,{text = "Watch out for bolts!"}) end},
		{time = 0, func = function(room) room:addObject(text,gw,gh/2+13,{text = "Move with A/D or left/right!"}) end},
		{time = 120, func = function(room) room:addObject(bolt,0,0) end},
		{time = 360, func = function(room) room:addObject(bolt,-45,0) end},
		{time = 360, func = function(room) room:addObject(bolt,45,0) end},
		{time = 360, func = function(room) room:addObject(bolt,-38,0) end},
		{time = 360, func = function(room) room:addObject(bolt,38,0) end},
		{time = 360, func = function(room) room:addObject(bolt,-30,0) end},
		{time = 360, func = function(room) room:addObject(bolt,30,0) end}
	},
	winTime = 560},
	-- level 5
	{spawn = {

	},
	winTime = 0},
	-- level 6
	{spawn = {

	},
	winTime = 0},
	-- level 7
	{spawn = {

	},
	winTime = 0},
	-- level 8
	{spawn = {

	},
	winTime = 0},
	-- level 9
	{spawn = {

	},
	winTime = 0},
	-- level 10
	{spawn = {

	},
	winTime = 0}
}

-- {time = 0, func = function(room)  end} ===== spawn object template

return levels