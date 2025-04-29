local libclass = require("libclass")

local libcommand = {}

-------------------------------------------------------------------------------
--                             ParsedCommand                                 --
-------------------------------------------------------------------------------

--- Распаршенная и закешированная команда.
--- @class ParsedCommand:Object
local ParsedCommand = libclass.Object:extend()

function ParsedCommand:exec()
    error("Must be overriden")
end

--- Простая конечная команда, ссылается на одну функцию из переданных в парсер.
--- @class SimpleParsedCommand:ParsedCommand
--- @field private fun function функция которая будет вызвана в методе exec.
--- @field private args [any] аргументы функции
local SimpleParsedCommand = ParsedCommand:extend()

function SimpleParsedCommand:initialize(fun, args)
    self.fun = fun
    self.args = args
end

function SimpleParsedCommand:exec()
    self.fun(table.unpack(self.args))
end

--- Повторяемая несколько раз команда
--- @class RepitableParsedCommand:ParsedCommand
--- @field private count integer количество повторений.
--- @field private command ParsedCommand команда для повторения.
local RepitableParsedCommand = ParsedCommand:extend()

function RepitableParsedCommand:initialize(count, command)
    self.count = count
    self.command = command
end

function RepitableParsedCommand:exec()
    for _ = 1, self.count do
        self.command:exec()
    end
end

--- Сложная составная команда, состоит из набора простых команд.
--- @class CompositeParsedCommand:ParsedCommand
--- @field private commands [ParsedCommand] список дочерних команд.
local CompositeParsedCommand = ParsedCommand:extend()

function CompositeParsedCommand:initialize(commands)
    self.commands = commands
end

function CompositeParsedCommand:exec()
    for _, command in ipairs(self.commands) do
        command:exec()
    end
end

-------------------------------------------------------------------------------
--                            CommandProcessor                               --
-------------------------------------------------------------------------------

--- Основной класс для обработки команд.
--- @class CommandProcessor:Object
--- @field private functions [function]
local CommandProcessor = libclass.Object:extend()

--- @param functions [function] массив всех функций которые могут быть вызваны.
function CommandProcessor:initialize(functions)
    self.functions = functions
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, string
function CommandProcessor:parseCommandName(command, index)
    local commandName = ""
    while index <= #command do
        local char = command:sub(index, index)
        if not char:match("%a") then
            break
        end
        commandName = commandName .. char
        index = index + 1
    end
    return index, commandName
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, integer
function CommandProcessor:parseRepitCount(command, index)
    local repitCount = ""
    while index <= #command do
        local char = command:sub(index, index)
        if not char:match("%d") then
            break
        end
        repitCount = repitCount .. char
        index = index + 1
    end
    return index, tonumber(repitCount)
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, string
function CommandProcessor:parseCommandArgument(command, index)
    local argument = ""
    while index <= #command do
        local char = command:sub(index, index)
        if not char:match("[%a%d]") then
            break
        end
        argument = argument .. char
        index = index + 1
    end
    return index, argument
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, [string]
function CommandProcessor:parseCommandArguments(command, index)
    local arguments = {}
    while index <= #command do
        local char = command:sub(index, index)
        if char == " " then
            index = index + 1
        elseif char:match("[%a%d]") then
            local argument
            index, argument = self:parseCommandArgument(command, index)
            table.insert(arguments, argument)
        elseif char:match("\n") then
            break
        else
            error("Unexpected char " .. char)
        end
    end
    return index, arguments
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, SimpleParsedCommand
function CommandProcessor:parseCommand(command, index)
    local commandName
    index, commandName = self:parseCommandName(command, index)
    local args
    index, args = self:parseCommandArguments(command, index)
    local func = self.functions[commandName]
    return index, SimpleParsedCommand:new(func, args)
end

--- @private
--- @param command string
--- @param index integer
--- @return integer, RepitableParsedCommand
function CommandProcessor:parseRepitableCommand(command, index)
    local count
    index, count = self:parseRepitCount(command, index)
    local parsedCommand
    index, parsedCommand = self:parseInternal(command, index, true)
    return index, RepitableParsedCommand:new(count, parsedCommand)
end

--- @private
--- @param command string вся команда от начала.
--- @param index integer? индекс начиная с которого нужно парсить команду.
--- @param singleMode boolean? если передан как true то будет распаршена одна первая команда а не все.
---      индекс на котором остановился парсинг, результат парсинга
--- @return            integer,                    ParsedCommand
function CommandProcessor:parseInternal(command, index, singleMode)
    index = index or 1
    singleMode = singleMode or false
    local commands = {}
    while index <= #command do
        local char = command:sub(index, index)
        if char:match("%a") then
            local parsedCommand
            index, parsedCommand = self:parseCommand(command, index)
            if singleMode then
                return index, parsedCommand
            end
            table.insert(commands, parsedCommand)
        elseif char:match("%d") then
            local parsedCommand
            index, parsedCommand = self:parseRepitableCommand(command, index)
            table.insert(commands, parsedCommand)
            if singleMode then
                return index, parsedCommand
            end
        elseif char:match("%s") then
            index = index + 1
        else
            error("Unexpected symbol " .. char)
        end
    end
    return index, CompositeParsedCommand:new(commands)
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
