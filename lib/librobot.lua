local component = require("component")
local sides = require("sides")
local libcommand = require("libcommand")

local librobot = {}
local robot = component.robot

-------------------------------------------------------------------------------
--                               Functions                                   --
-------------------------------------------------------------------------------

--- Набор функций которые робот может исполнять
local functions = {}
librobot.functions = functions

-------------------------------------------------------------------------------

local processor = libcommand.CommandProcessor:new(functions)

--- Парсит (не выполняет сразу) переданную роботу команду.
--- @param command string команда для обработки
--- @return ParsedCommand
function librobot.parse(command)
    return processor:parse(command)
end

return librobot
