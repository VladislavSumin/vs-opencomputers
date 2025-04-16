--- Набор утилит для работы с рантайм загрузкой кода.

local fs = require("libfs")

local libload = {}

--- Загружает исполняемый код из файла
--- @param path string путь к исполняемому файлу
--- @param env table таблица для использования в качестве _G при загрузке кода.
function libload.loadFromFile(path, env)
    local data, error = fs.readFileToString(path)
    if not data then
        return nil, error
    end

    local chunk, error = load(data, path, "t", env)
    return chunk, error
end

return libload
