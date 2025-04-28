local component = require("component")
local sides = require("sides")

local librobot = {}

-------------------------------------------------------------------------------
--                               Functions                                   --
-------------------------------------------------------------------------------

--- Набор функций которые робот может исполнять
local functions = {}
librobot.functions = functions

--- Перемещает робота в указанном направлении
--- @param direction string направление для движения
function functions.move(direction)
    print("move " .. direction)
end

-------------------------------------------------------------------------------
--                                  Mode                                     --
-------------------------------------------------------------------------------

--- @enum Mode
local Mode = {
    number = 1,
    command = 2,
}

-------------------------------------------------------------------------------
--                                 Command                                   --
-------------------------------------------------------------------------------

--- @class Command
--- @field fun function ссылка на нужную функцию
--- @field args [string] аргументы функции
local Command = {}

--- @return Command
function Command.new(fun, args)
    return {
        fun = fun,
        args = args,
    } --[[@as Command]]
end

--- Выполняет команду, возвращает результат выполнения.
function Command:exec()
    return self.fun(table.unpack(self.args))
end

-------------------------------------------------------------------------------

--- @param message string
local function returnError(message)
    return false, nil, message
end

--- Парсит число до первого иного символа или конца строки
---         индекс   число
--- @return integer, integer
local function parseNumber(command, index)
    local number = ""
    while index <= #command do
        local char = command:sub(index, index)
        if ~char:match("%d") then
            break
        end
        index = index + 1
    end
    return index, tonumber(number) --[[@as integer]]
end

--- Парсит название функции а так же ее аргументы если таковые есть.
--- @param command string
--- @param index integer
---         индекс   команда
--- @return integer, Command
local function parseCommand(command, index)
    -- Парсим имя функции.
    local functionName = ""
    while index <= #command do
        local char = command:sub(index, index)
        if ~char:match("%a") then
            break
        end
        index = index + 1
        functionName = functionName .. char
    end
    local fun = librobot.functions[functionName]

    return index, Command.new(fun, {})
end

--- @param command string вся команда целиком
--- @param index integer? индекс с которого нужно начинать парсинг команды
---         ошибка   индекс    ошибка
--- @return boolean, integer?, string
local function parseInternal(command, index)
    index = index or 1

    local mode = Mode.number
    local repeatCount = 1

    while index <= #command do
        local char = command:sub(index, index)
        if mode == Mode.number and char:match("%d") then
            index, repeatCount = parseNumber(command, index)
            mode = Mode.command
        elseif mode == Mode.command and char:match("%a") then
            index = parseCommand(command, index)
        elseif char:match("%s") then
            index = index + 1
        elseif char == "(" then
            return returnError("bracket not implemented yet")
        elseif char == ")" then
            return returnError("bracket not implemented yet")
        else
            return returnError("Unexpected char " .. char)
        end
    end

    return true, index
end

--- Парсит (не выполняет сразу) переданную роботу команду.
--- @param command string команда для обработки
---          ошибка  набор команд   ошибка
--- @return boolean,     nil,       string?
function librobot.parse(command)
    local result, _, error = parseInternal(command)
    return result, nil, error
end

return librobot
