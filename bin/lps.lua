-- Выводит текущие координаты согласно LPS.

local liblps = require("liblps")
local libcoord = require("libcoord")

print("Coords: " .. tostring(liblps.currentPosition))
print("Rotation: " .. libcoord.Rotation.toString(liblps.currentRotation))
