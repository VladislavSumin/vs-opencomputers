
local component = require("component")
local sides = require("sides")

local librobot = {
    -- Определяем компонент робота локально что бы его можно было переопределить в тестах
    robot = component.robot,
}

local function executeCommand(command)
    if command == "mu" then
        librobot.robot.move(sides.up)
    elseif command == "md" then
        librobot.robot.move(sides.down)
    elseif command == "mf" then
        librobot.robot.move(sides.forward)
    elseif command == "mb" then
        librobot.robot.move(sides.back)
    elseif command == "tr" then
        librobot.robot.turn(true)
    elseif command == "tl" then
        librobot.robot.turn(false)
    else
        return false, "Unknown command: " .. command
    end
    return true
end

--- @return boolean, string?
function executeInternal(commands)
    local index = 1

    --- Парсит число в начале команды.
    --- @return number число повторений команды
    local function parseLeadingNumber()
        local number = ""
        while index <= #commands and commands:sub(index, index):match("%d") do
            number = number .. commands:sub(index, index)
            index = index + 1
        end
        return tonumber(number) or 1
    end

    local function parseCommand()
        local command = ""
        while index <= #commands and commands:sub(index, index):match("%a") do
            command = command .. commands:sub(index, index)
            index = index + 1
        end
        return command
    end

    while index <= #commands do
        local count = parseLeadingNumber()
        local command = parseCommand()
        
        if index <= #commands and commands:sub(index, index) == " " then
            index = index + 1
        end
        
        for i = 1, count do
            local success, error = executeCommand(command)
            if not success then
                return false, error
            end
        end
    end
    return true
end

--- Выполняет команды робота.
--- @param commands string
--- @return boolean, string?
function librobot.execute(commands)
    return executeInternal(commands)
end

return librobot