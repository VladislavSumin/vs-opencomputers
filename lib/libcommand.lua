local libclass = require("libclass")

local libcommand = {}

-------------------------------------------------------------------------------
--                             ParsedCommand                                 --
-------------------------------------------------------------------------------

--- Распаршенная и закешированная команда.
--- @class ParsedCommand:Object
--- @field protected count integer количество повторений команды
local ParsedCommand = libclass.Object:extend()

function ParsedCommand:exec()
    error("Must be overriden")
end

--- Простая конечная команда, ссылается на одну функцию из переданных в парсер.
--- @class SimpleParsedCommand:ParsedCommand
--- @field private fun function функция которая будет вызвана в методе exec.
--- @field private args [any] аргументы функции
local SimpleParsedCommand = ParsedCommand:extend()

function SimpleParsedCommand:initialize(count, fun, args)
    self.count = count
    self.fun = fun
    self.args = args
end

function SimpleParsedCommand:exec()
    for _ = 1, self.count do
        self.fun(table.unpack(self.args))
    end
end

--- Сложная составная команда, состоит из набора простых команд.
--- @class CompositeParsedCommand:ParsedCommand
--- @field private funs [ParsedCommand] список дочерних команд.
local CompositeParsedCommand = ParsedCommand:extend()

function CompositeParsedCommand:initialize(count, funs)
    self.count = count
    self.funs = funs
end

function CompositeParsedCommand:exec()
    for _ = 1, self.count do
        for _, fun in ipairs(self.funs) do
            fun:exec()
        end
    end
end

-------------------------------------------------------------------------------
--                            CommandProcessor                               --
-------------------------------------------------------------------------------

--- Основной класс для обработки команд.
--- @class CommandProcessor
--- @field private functions [function]
local CommandProcessor = libclass.Object:extend()

--- @param functions [function] массив всех функций которые могут быть вызваны.
function CommandProcessor:initialize(functions)
    self.functions = functions
end

--- @private
--- @param command string вся команда от начала.
--- @param index integer? индекс начиная с которого нужно парсить команду.
---      индекс на котором остановился парсинг, результат парсинга
--- @return            integer,                    ParsedCommand
function CommandProcessor:parseInternal(command, index)
    index = index or 1
    return index, ParsedCommand:new()
end

--- Парсит команду не выполняя её. Может использоваться для кеширования команд что бы избежать их повторного парсинга.
--- @param command string команда для обработки.
--- @return ParsedCommand
function CommandProcessor:parse(command)
    local _, parsedCommand = self:parseInternal(command)
    return parsedCommand
end

libcommand.CommandProcessor = CommandProcessor
return libcommand
