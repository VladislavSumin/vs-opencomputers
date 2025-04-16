-- Определяет разные типы координат, переводы из одних координат в другие и тд.

local libclass = require("libclass")

local libcoord = {}

--- @class WorldCoord:Object
--- @field x number
--- @field y number
--- @field z number
local WorldCoord = libclass.Object:extend()
function WorldCoord:initialize(x, y, z)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

libcoord.WorldCoord = WorldCoord
return libcoord
