-- Определяет разные типы координат.

local libclass = require("libclass")

local libcoord = {}

--- Базовые координаты, используются только локально для реализации общих для всех координат методов.
--- @class Coord: Object
--- @field x number
--- @field y number
--- @field z number
local Coord = libclass.Object:extend()

function Coord:initialize(x, y, z)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

--- Координаты относительно истинного или локального (когда определить настоящие координаты невозможно) центра мира.
--- @class WorldCoord: Coord
local WorldCoord = Coord:extend()

--- Координаты относительно текущего положения робота.
--- В соответствии с общей реализацией координат в этой системе отчета ось +Z направлена по направлению взгляда робота.
--- Ось +X в свою очередь находится по правую руку от +Z
--- См. compas.txt
--- @class LocalCoord: Coord
local LocalCoord = Coord:extend()

libcoord.WorldCoord = WorldCoord
libcoord.LocalCoord = LocalCoord

return libcoord
