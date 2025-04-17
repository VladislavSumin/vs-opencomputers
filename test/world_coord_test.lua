local test = require("libtest")
local libcoord = require("libcoord")

local WorldCoord = libcoord.WorldCoord
local Rotation = libcoord.Rotation
local Direction = libcoord.Direction

function createWorldCoordTest()
    local wc = WorldCoord:new(1, 2, 3)
    test.assertEquals(1, wc.x)
    test.assertEquals(2, wc.y)
    test.assertEquals(3, wc.z)
end

-- Тесты для вертикального движения
function testVerticalMovement()
    local coord = WorldCoord:new(0, 0, 0)

    -- Движение вверх при любом направлении робота
    coord:move(Rotation.north, Direction.up)
    test.assertEquals(coord.y, 1)
    coord:move(Rotation.south, Direction.up)
    test.assertEquals(coord.y, 2)

    -- Движение вниз при любом направлении робота
    coord:move(Rotation.west, Direction.down)
    test.assertEquals(coord.y, 1)
    coord:move(Rotation.east, Direction.down)
    test.assertEquals(coord.y, 0)
end

-- Тесты для направления north
function testNorthOrientation()
    local coord = WorldCoord:new(0, 0, 0)

    coord:move(Rotation.north, Direction.forward) -- -Z
    test.assertEquals(coord.z, -1)
    coord:move(Rotation.north, Direction.back)    -- +Z
    test.assertEquals(coord.z, 0)
    coord:move(Rotation.north, Direction.left)    -- -X (west)
    test.assertEquals(coord.x, -1)
    coord:move(Rotation.north, Direction.right)   -- +X (east)
    test.assertEquals(coord.x, 0)
end

-- Тесты для направления south
function testSouthOrientation()
    local coord = WorldCoord:new(0, 0, 0)

    coord:move(Rotation.south, Direction.forward) -- +Z
    test.assertEquals(coord.z, 1)
    coord:move(Rotation.south, Direction.back)    -- -Z
    test.assertEquals(coord.z, 0)
    coord:move(Rotation.south, Direction.left)    -- +X (east)
    test.assertEquals(coord.x, 1)
    coord:move(Rotation.south, Direction.right)   -- -X (west)
    test.assertEquals(coord.x, 0)
end

-- Тесты для направления west
function testWestOrientation()
    local coord = WorldCoord:new(0, 0, 0)

    coord:move(Rotation.west, Direction.forward) -- -X
    test.assertEquals(coord.x, -1)
    coord:move(Rotation.west, Direction.back)    -- +X
    test.assertEquals(coord.x, 0)
    coord:move(Rotation.west, Direction.left)    -- +Z (south)
    test.assertEquals(coord.z, 1)
    coord:move(Rotation.west, Direction.right)   -- -Z (north)
    test.assertEquals(coord.z, 0)
end

-- Тесты для направления east
function testEastOrientation()
    local coord = WorldCoord:new(0, 0, 0)

    coord:move(Rotation.east, Direction.forward) -- +X
    test.assertEquals(coord.x, 1)
    coord:move(Rotation.east, Direction.back)    -- -X
    test.assertEquals(coord.x, 0)
    coord:move(Rotation.east, Direction.left)    -- -Z (north)
    test.assertEquals(coord.z, -1)
    coord:move(Rotation.east, Direction.right)   -- +Z (south)
    test.assertEquals(coord.z, 0)
end
