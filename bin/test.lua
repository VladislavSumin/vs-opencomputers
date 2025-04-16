-- Запускает все юнит тесты в папке /test

local fs = require("libfs")
local libload = require("libload")

local TEST_DIR = "/test"

assert(fs.isDirectory(TEST_DIR), "Test directory " .. TEST_DIR .. " not exists")

local successTestsCount = 0
local failedTestsCount = 0

local failedTests = {}

--- Выполняет тесты внутри testTable
local function processTestTable(path, testTable)
    for name, test in pairs(testTable) do
        local fullName = path .. "#" .. name
        if type(test) == "function" then
            print(fullName .. ": executing ")
            local result, error = pcall(test)
            if result then
                print(fullName .. ": success")
                successTestsCount = successTestsCount + 1
            else
                print(fullName .. ": error:\n" .. error)
                failedTestsCount = failedTestsCount + 1
                table.insert(failedTests, fullName)
            end
        end
    end
end

--- Загружает файл unit теста и выполняет тесты внутри
local function processUnitTestFile(path)
    local env = setmetatable({}, { __index = _G })
    local chunk, err = libload.loadFromFile(path, env)

    if not chunk then
        error("Failed to load file " .. path .. "\n" .. err)
    end

    -- Тесты строятся таким образом, что объявляют тестовые функции глобально.
    -- Таким образом сам тестовый файл ничего не делает, лишь прогружает функции в таблицу.
    chunk()

    processTestTable(path, env)
end

-- Обходим все тестовые файлы и выполняем unit тесты внутри.
for file in fs.list(TEST_DIR) do
    processUnitTestFile(fs.concat(TEST_DIR, file))
end

print("-------------------------------------")
print("Total tests: " .. (successTestsCount + failedTestsCount))
if failedTestsCount > 0 then
    local message = "Not all tests passed!\nFailed count = " .. failedTestsCount .. "\nFailed tests:"
    for _, name in ipairs(failedTests) do
        message = message .. "\n\t" .. name
    end
    io.stderr:write(message)
    return -1
end
