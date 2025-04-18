-- Библиотека для компактного хранения информации о блоках в чанках.

local libclass = require("libclass")
local libbitchunk = {}

-------------------------------------------------------------------------------
--                                BitChunk                                   --
-------------------------------------------------------------------------------

--- @class BitChunk: Object
local BitChunk = libclass.Object:extend()

-- Константы для размеров чанка
local CHUNK_SIZE = 16
local CHUNK_SIZE_SQUARED = CHUNK_SIZE * CHUNK_SIZE
local CHUNK_SIZE_CUBED = CHUNK_SIZE * CHUNK_SIZE * CHUNK_SIZE

--- Инициализирует новый чанк для хранения булевых значений.
--- Чанк представляет собой трехмерный массив размером 16x16x16,
--- где каждое значение хранится в виде бита.
function BitChunk:initialize()
    -- Используем числа для хранения битов
    -- Каждое число хранит 32 бита, поэтому нам нужно CHUNK_SIZE_CUBED / 32 чисел
    self.data = {}
    for i = 1, math.ceil(CHUNK_SIZE_CUBED / 32) do
        self.data[i] = 0
    end
end

--- Получение индекса в массиве данных
--- @param x number
--- @param y number
--- @param z number
--- @return number
--- @return number
local function getIndex(x, y, z)
    local index = (x - 1) + (y - 1) * CHUNK_SIZE + (z - 1) * CHUNK_SIZE_SQUARED
    local arrayIndex = math.floor(index / 32) + 1
    local bitIndex = index % 32
    return arrayIndex, bitIndex
end

--- Установка значения в чанке
--- @param x number
--- @param y number
--- @param z number
--- @param value boolean
function BitChunk:set(x, y, z, value)
    if x < 1 or x > CHUNK_SIZE or y < 1 or y > CHUNK_SIZE or z < 1 or z > CHUNK_SIZE then
        error("Coordinates out of bounds")
    end
    
    local arrayIndex, bitIndex = getIndex(x, y, z)
    if value then
        self.data[arrayIndex] = self.data[arrayIndex] | (1 << bitIndex)
    else
        self.data[arrayIndex] = self.data[arrayIndex] & ~(1 << bitIndex)
    end
end

--- Получение значения из чанка
--- @param x number
--- @param y number
--- @param z number
--- @return boolean
function BitChunk:get(x, y, z)
    if x < 1 or x > CHUNK_SIZE or y < 1 or y > CHUNK_SIZE or z < 1 or z > CHUNK_SIZE then
        error("Coordinates out of bounds")
    end
    
    local arrayIndex, bitIndex = getIndex(x, y, z)
    return (self.data[arrayIndex] & (1 << bitIndex)) ~= 0
end

-- Очистка чанка (установка всех значений в false)
function BitChunk:clear()
    for i = 1, #self.data do
        self.data[i] = 0
    end
end

-------------------------------------------------------------------------------
--                               BitChunks                                   --
-------------------------------------------------------------------------------

--- Хранилище чанков.
--- @class BitChunks: Object
local BitChunks = libclass.Object:extend()

--- Инициализирует новое хранилище чанков.
function BitChunks:initialize()
    self.chunks = {}
end

--- Добавляет новый чанк в хранилище.
--- @param coord ChunkCoord Координаты чанка
--- @return BitChunk Созданный чанк
function BitChunks:addChunk(coord)
    local key = tostring(coord)
    if self.chunks[key] then
        error("Chunk already exists at " .. key)
    end
    
    local chunk = BitChunk:new()
    self.chunks[key] = chunk
    return chunk
end

--- Удаляет чанк из хранилища.
--- @param coord ChunkCoord Координаты чанка
function BitChunks:removeChunk(coord)
    local key = tostring(coord)
    if not self.chunks[key] then
        error("Chunk does not exist at " .. key)
    end
    
    self.chunks[key] = nil
end

--- Получает чанк по его координатам.
--- @param coord ChunkCoord Координаты чанка
--- @return BitChunk? Чанк или nil, если чанк не существует
function BitChunks:getChunk(coord)
    return self.chunks[tostring(coord)]
end

libbitchunk.BitChunk = BitChunk
libbitchunk.BitChunks = BitChunks
return libbitchunk
