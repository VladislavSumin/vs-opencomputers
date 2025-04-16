-- Набор полезный утилит, расширающих базовый интерфейс файловой системы.

local fs = require("filesystem")

--- Полностью читает файл в строку.
--- Возврашщает или данные ввиде строки, или ошибку вторым возвращаемым значением.
--- @param path string путь к файлу.
--- @return string?, string? - data, error
function fs.readFileToString(path)
    fileHandler, error = fs.open(path, "r")
    if not fileHandler then
        return nil, error
    end

    local data = ""
    repeat
        local read = fileHandler:read(math.maxinteger)
        data = data .. (read or "")
    until not read

    fileHandler:close()

    return data, nil
end

return fs
