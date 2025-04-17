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

function Rotation.toString(rotation)
    if rotation == Rotation.north then
        return "North / -Z"
    elseif rotation == Rotation.south then
        return "South / +Z"
    elseif rotation == Rotation.west then
        return "West / -X"
    elseif rotation == Rotation.east then
        return "East / +X"
    else
        error("Unknown rotation: " .. tostring(rotation))
    end
end

-------------------------------------------------------------------------------
--                                Direction                                  --
-------------------------------------------------------------------------------

--- Указывает направление движения в соответствии с compass.txt
--- @enum Direction
local Direction = {
    down = 0,
    up = 1,
    forward = 3,
    back = 2,
    left = 5,
    right = 4,
}

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

function Coord.meta:__tostring()
    return self.x .. ", " .. self.y .. ", " .. self.z
end

-------------------------------------------------------------------------------
--                               WorldCoord                                  --
-------------------------------------------------------------------------------

--- Координаты относительно истинного или локального (когда определить настоящие координаты невозможно) центра мира.
--- @class WorldCoord: Coord
local WorldCoord = Coord:extend()

--- Сдвигает координаты self.
--- @param rotation Rotation текущее направление взгляда робота
--- @param direction Direction направление в котором робот двигается (относительно себя и своего взгляда)
function WorldCoord:move(rotation, direction)
    -- Обработка вертикальных движений (up/down)
    if direction == Direction.down or direction == Direction.up then
        self.y = self.y + (direction == 1 and 1 or -1)
        return
    end

    -- Проверка, что направление робота горизонтальное
    local left_right = {
        [2] = { left = 4, right = 5 }, -- north
        [3] = { left = 5, right = 4 }, -- south
        [4] = { left = 3, right = 2 }, -- west
        [5] = { left = 2, right = 3 }, -- east
    }

    -- Определение глобального направления движения
    local global_dir
    if direction == Direction.forward then
        global_dir = rotation
    elseif direction == Direction.back then
        global_dir = Rotation.opposite(rotation)
    elseif direction == Direction.left then
        global_dir = left_right[rotation].left
    elseif direction == Direction.right then
        global_dir = left_right[rotation].right
    else
        error("Unsupported movement direction: " .. tostring(direction))
    end

    -- Получение оси и изменения для глобального направления
    local axis_info = {
        [2] = { axis = 'z', delta = -1 }, -- north
        [3] = { axis = 'z', delta = 1 },  -- south
        [4] = { axis = 'x', delta = -1 }, -- west
        [5] = { axis = 'x', delta = 1 },  -- east
    }

    local info = axis_info[global_dir]
    if not info then
        error("Unsupported global direction: " .. tostring(global_dir))
    end

    self[info.axis] = self[info.axis] + info.delta
end

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
libcoord.Direction = Direction
libcoord.WorldCoord = WorldCoord
libcoord.LocalCoord = LocalCoord

return libcoord
