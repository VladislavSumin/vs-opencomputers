local test = require("libtest")
local libcoord = require("libcoord")

local ChunkCoord = libcoord.ChunkCoord
local WorldCoord = libcoord.WorldCoord

-- Тест создания координат чанка
function createTest()
    local coord = ChunkCoord:new(1, 2, 3)
    test.assertEquals(1, coord.x)
    test.assertEquals(2, coord.y)
    test.assertEquals(3, coord.z)
end

-- Тест получения координат чанка из мировых координат (положительные значения)
function fromWorldCoordPositiveTest()
    -- Тест в центре чанка
    local worldCoord = WorldCoord:new(8, 8, 8)
    local chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(0, chunkCoord.x)
    test.assertEquals(0, chunkCoord.y)
    test.assertEquals(0, chunkCoord.z)
    
    -- Тест на границе чанка
    worldCoord = WorldCoord:new(15, 15, 15)
    chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(0, chunkCoord.x)
    test.assertEquals(0, chunkCoord.y)
    test.assertEquals(0, chunkCoord.z)
    
    -- Тест в следующем чанке
    worldCoord = WorldCoord:new(16, 16, 16)
    chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(1, chunkCoord.x)
    test.assertEquals(1, chunkCoord.y)
    test.assertEquals(1, chunkCoord.z)
end

-- Тест получения координат чанка из мировых координат (отрицательные значения)
function fromWorldCoordNegativeTest()
    -- Тест в центре отрицательного чанка
    local worldCoord = WorldCoord:new(-8, -8, -8)
    local chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(-1, chunkCoord.x)
    test.assertEquals(-1, chunkCoord.y)
    test.assertEquals(-1, chunkCoord.z)
    
    -- Тест на границе отрицательного чанка
    worldCoord = WorldCoord:new(-1, -1, -1)
    chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(-1, chunkCoord.x)
    test.assertEquals(-1, chunkCoord.y)
    test.assertEquals(-1, chunkCoord.z)
    
    -- Тест в следующем отрицательном чанке
    worldCoord = WorldCoord:new(-16, -16, -16)
    chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(-1, chunkCoord.x)
    test.assertEquals(-1, chunkCoord.y)
    test.assertEquals(-1, chunkCoord.z)
    
    worldCoord = WorldCoord:new(-17, -17, -17)
    chunkCoord = ChunkCoord.fromWorldCoord(worldCoord)
    test.assertEquals(-2, chunkCoord.x)
    test.assertEquals(-2, chunkCoord.y)
    test.assertEquals(-2, chunkCoord.z)
end

-- Тест получения начальных координат чанка
function getStartWorldCoordTest()
    local chunkCoord = ChunkCoord:new(1, 2, 3)
    local start = chunkCoord:getStartWorldCoord()
    test.assertEquals(16, start.x)
    test.assertEquals(32, start.y)
    test.assertEquals(48, start.z)
    
    chunkCoord = ChunkCoord:new(-1, -2, -3)
    start = chunkCoord:getStartWorldCoord()
    test.assertEquals(-16, start.x)
    test.assertEquals(-32, start.y)
    test.assertEquals(-48, start.z)
end

-- Тест получения конечных координат чанка
function getEndWorldCoordTest()
    local chunkCoord = ChunkCoord:new(1, 2, 3)
    local endCoord = chunkCoord:getEndWorldCoord()
    test.assertEquals(31, endCoord.x)
    test.assertEquals(47, endCoord.y)
    test.assertEquals(63, endCoord.z)
    
    chunkCoord = ChunkCoord:new(-1, -2, -3)
    endCoord = chunkCoord:getEndWorldCoord()
    test.assertEquals(-1, endCoord.x)
    test.assertEquals(-17, endCoord.y)
    test.assertEquals(-33, endCoord.z)
end 