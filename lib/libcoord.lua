-- Определяет разные типы координат.

local libclass = require("libclass")

local libcoord = {}

-------------------------------------------------------------------------------
--                                Rotation                                   --
-------------------------------------------------------------------------------

--- Указывает направление взгляда робота в соответствии с compass.txt
--- @enum Rotation
local Rotation = {
    north = 2,
    south = 3,
    west = 4,
    east = 5
}

--- Возвращает сторону противоположную переданной
--- @param rotation Rotation
--- @return Rotation
function Rotation.opposite(rotation)
    local mod = rotation % 2
    return ((mod + 1) % 2 + rotation - mod) --[[@as Rotation]]
end

local _clockwise = { 5, 4, 2, 3 }
local _contrClockwise = { 4, 5, 3, 2 }

--- @param rotation Rotation
--- @param clockwice boolean
--- @return Rotation
function Rotation.rotate(rotation, clockwice)
    if clockwice then
        return _clockwise[rotation - 1]
    else
        return _contrClockwise[rotation - 1]
    end
end

-------------------------------------------------------------------------------
--                                  Coord                                    --
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
--                               WordlCoord                                  --
-------------------------------------------------------------------------------

--- Координаты относительно истинного или локального (когда определить настоящие координаты невозможно) центра мира.
--- @class WorldCoord: Coord
local WorldCoord = Coord:extend()

-------------------------------------------------------------------------------
--                               LocalCoord                                  --
-------------------------------------------------------------------------------

--- Координаты относительно текущего положения робота.
--- В соответствии с общей реализацией координат в этой системе отчета ось +Z направлена по направлению взгляда робота.
--- Ось +X в свою очередь находится по правую руку от +Z
--- См. compas.txt
--- @class LocalCoord: Coord
local LocalCoord = Coord:extend()

-------------------------------------------------------------------------------

libcoord.Rotation = Rotation
libcoord.WorldCoord = WorldCoord
libcoord.LocalCoord = LocalCoord

return libcoord
