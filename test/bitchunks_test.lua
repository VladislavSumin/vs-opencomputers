local test = require("libtest")
local libbitchunk = require("libbitchunk")
local libcoord = require("libcoord")

local BitChunks = libbitchunk.BitChunks
local ChunkCoord = libcoord.ChunkCoord
local WorldCoord = libcoord.WorldCoord

-- Тест создания хранилища
function createTest()
    local chunks = BitChunks:new()
    test.assertNotNil(chunks)
    test.assertNotNil(chunks.chunks)
end

-- Тест добавления и удаления чанков
function addRemoveTest()
    local chunks = BitChunks:new()
    local coord = ChunkCoord:new(1, 2, 3)
    
    -- Добавление чанка
    local chunk = chunks:addChunk(coord)
    test.assertNotNil(chunk)
    test.assertEquals(chunk, chunks:getChunk(coord))
    
    -- Попытка повторного добавления
    test.assertError(function() chunks:addChunk(coord) end)
    
    -- Удаление чанка
    chunks:removeChunk(coord)
    test.assertNil(chunks:getChunk(coord))
    
    -- Попытка удаления несуществующего чанка
    test.assertError(function() chunks:removeChunk(coord) end)
end

-- Тест получения чанка
function getChunkTest()
    local chunks = BitChunks:new()
    local coord = ChunkCoord:new(1, 2, 3)
    
    -- Получение несуществующего чанка
    test.assertNil(chunks:getChunk(coord))
    
    -- Добавление и получение чанка
    local chunk = chunks:addChunk(coord)
    test.assertEquals(chunk, chunks:getChunk(coord))
    
    -- Получение чанка с другими координатами
    test.assertNil(chunks:getChunk(ChunkCoord:new(4, 5, 6)))
end

-- Тест работы с отрицательными координатами
function negativeCoordsTest()
    local chunks = BitChunks:new()
    local coord = ChunkCoord:new(-1, -2, -3)
    
    -- Добавление чанка с отрицательными координатами
    local chunk = chunks:addChunk(coord)
    test.assertNotNil(chunk)
    test.assertEquals(chunk, chunks:getChunk(coord))
    
    -- Удаление чанка с отрицательными координатами
    chunks:removeChunk(coord)
    test.assertNil(chunks:getChunk(coord))
end

-- Тест работы с несколькими чанками
function multipleChunksTest()
    local chunks = BitChunks:new()
    local coords = {
        ChunkCoord:new(1, 2, 3),
        ChunkCoord:new(-1, -2, -3),
        ChunkCoord:new(0, 0, 0)
    }
    
    -- Добавление нескольких чанков
    for _, coord in ipairs(coords) do
        local chunk = chunks:addChunk(coord)
        test.assertNotNil(chunk)
        test.assertEquals(chunk, chunks:getChunk(coord))
    end
    
    -- Проверка, что чанки не перезаписывают друг друга
    for _, coord in ipairs(coords) do
        test.assertNotNil(chunks:getChunk(coord))
    end
    
    -- Удаление всех чанков
    for _, coord in ipairs(coords) do
        chunks:removeChunk(coord)
        test.assertNil(chunks:getChunk(coord))
    end
end 