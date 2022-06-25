-- this file has methods related to the spiral search

-- Creates a spiral around a point to get squares in order of proximity for searching nearby
SpiralSearch = {}
--SpiralSearch.__index = SpiralSearch

function SpiralSearch:new(x, y, range)
	local o = {}
	setmetatable(o, self)
	--self.__index = self

	o.x = math.floor(x)
	o.y = math.floor(y)

	o.ix = 0
	o.iy = 0
	o.deltax = 0
	o.deltay = -1
	o.width = range * 2
	o.height = range * 2

	return o
end

function SpiralSearch:forMax()
	return math.max(self.width, self.height) ^ 2
end

function SpiralSearch:getX()
	return self.x + self.ix
end

function SpiralSearch:getY()
	return self.y + self.iy
end

function SpiralSearch:next()
	if (self.ix == self.iy
	or (self.ix < 0 and self.ix == 0-self.iy)
	or (self.ix > 0 and self.ix == 1-self.iy)) then
		-- change direction
		local dx = 0-self.deltay
		local dy = self.deltax
		self.deltax = dx
		self.deltay = dy
	end

	self.ix = self.ix + self.deltax;
	self.iy = self.iy + self.deltay;
end