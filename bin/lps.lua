-- Выводит текущие координаты согласно LPS.

local liblps = require("liblps")
local libcoord = require("libcoord")
local shell = require("shell")

local args, _ = shell.parse(...)

if #args > 0 then
    if #args < 3 then
        print("Ошибка: недостаточно аргументов")
        print("Использование: lps [x y z [направление]]")
        print("  x, y, z - координаты (числа)")
        print("  направление - одно из: north, south, east, west")
        return
    end

    local x = tonumber(args[1])
    local y = tonumber(args[2])
    local z = tonumber(args[3])
    
    if not (x and y and z) then
        print("Ошибка: координаты должны быть числами")
        return
    end

    liblps.currentPosition.x = x
    liblps.currentPosition.y = y
    liblps.currentPosition.z = z

    if #args >= 4 then
        local direction = args[4]:lower()
        if direction == "north" then
            liblps.currentRotation = libcoord.Rotation.north
        elseif direction == "south" then
            liblps.currentRotation = libcoord.Rotation.south
        elseif direction == "east" then
            liblps.currentRotation = libcoord.Rotation.east
        elseif direction == "west" then
            liblps.currentRotation = libcoord.Rotation.west
        else
            print("Ошибка: неверное направление")
            print("Доступные направления: north, south, east, west")
            return
        end
    end
end

print("Coords: " .. tostring(liblps.currentPosition))
print("Rotation: " .. libcoord.Rotation.toString(liblps.currentRotation))
