local test = require("libtest")
local libbitchunk = require("libbitchunk")

local BitChunk = libbitchunk.BitChunk

-- Тест создания чанка
function createTest()
    local chunk = BitChunk:new()
    test.assertNotNil(chunk)
    test.assertNotNil(chunk.data)
end

-- Тест установки и получения значений
function setGetTest()
    local chunk = BitChunk:new()
    
    -- Установка и проверка true
    chunk:set(1, 1, 1, true)
    test.assertTrue(chunk:get(1, 1, 1))
    
    -- Установка и проверка false
    chunk:set(1, 1, 1, false)
    test.assertFalse(chunk:get(1, 1, 1))
    
    -- Проверка нескольких позиций
    chunk:set(16, 16, 16, true)
    test.assertTrue(chunk:get(16, 16, 16))
    test.assertFalse(chunk:get(1, 1, 1))
end

-- Тест граничных значений
function boundaryTest()
    local chunk = BitChunk:new()
    
    -- Проверка корректных границ
    chunk:set(1, 1, 1, true)
    chunk:set(16, 16, 16, true)
    
    -- Проверка выхода за границы
    local success, err = pcall(function() chunk:set(0, 1, 1, true) end)
    test.assertFalse(success)
    
    success, err = pcall(function() chunk:set(17, 1, 1, true) end)
    test.assertFalse(success)
    
    success, err = pcall(function() chunk:get(0, 1, 1) end)
    test.assertFalse(success)
    
    success, err = pcall(function() chunk:get(1, 17, 1) end)
    test.assertFalse(success)
end

-- Тест очистки чанка
function clearTest()
    local chunk = BitChunk:new()
    
    -- Заполняем чанк значениями true
    for x = 1, 16 do
        for y = 1, 16 do
            for z = 1, 16 do
                chunk:set(x, y, z, true)
            end
        end
    end
    
    -- Проверяем, что все значения true
    for x = 1, 16 do
        for y = 1, 16 do
            for z = 1, 16 do
                test.assertTrue(chunk:get(x, y, z))
            end
        end
    end
    
    -- Очищаем чанк
    chunk:clear()
    
    -- Проверяем, что все значения false
    for x = 1, 16 do
        for y = 1, 16 do
            for z = 1, 16 do
                test.assertFalse(chunk:get(x, y, z))
            end
        end
    end
end

-- Тест эффективности хранения
function storageTest()
    local chunk = BitChunk:new()
    
    -- Проверяем, что используется минимальное количество памяти
    -- Каждое число хранит 32 бита, поэтому для 4096 бит (16x16x16) нужно 128 чисел
    test.assertEquals(#chunk.data, 128)
    
    -- Проверяем, что все числа инициализированы нулями
    for i = 1, #chunk.data do
        test.assertEquals(chunk.data[i], 0)
    end
end 