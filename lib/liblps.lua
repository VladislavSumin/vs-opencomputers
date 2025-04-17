--- Локальная система позиционирования (LPS). Аналог GPS, но использует стартовые координаты и информацию
--- о перемещениях робота.

local libcoord = require("libcoord")
local component = require("component")
local WorldCoord = libcoord.WorldCoord
local Rotation = libcoord.Rotation

--- В opencomputers существует два способа работы с апи робота
--- 1) Через api компонента robot (команды move(direction))
--- 2) Через require("robot") (команды up(), down(), etc).
--- Нам нужно перехватывать события первого апи так как они более низкоуровневые. Второй способ просто дилегирует
--- все команды в первое апи.
local robot = component.robot

local liblps = {}

--- Ткущая позиция в локальной системе координат.
--- Вы можете задать ее вручную или использовать GPS для первичного определения координат.
--- Внимание:
--- Для оптимизации производительности, библиотека не создает новый вектор при каждом изменении а использует текущий.
--- Не мутируйте этот вектор напрямую если не хотите задать координаты, а так жу учитывайте что вектор изменяет свои
--- значение при каждом перемещении робота.
liblps.currentPosition = WorldCoord:new()

--- Текущее направление взгляда робота.
--- Так же можно или задать вручную или использовать информацию с датчиков навигации / GPS + движение.
--- @type Rotation
liblps.currentRotation = Rotation.north

--- Перехватываем вызовы move.
local originalMove = robot.move
robot.move = function(direction)
    local ret = originalMove(direction)
    if ret then
        liblps.currentPosition:move(liblps.currentRotation, direction)
    end
    return ret
end

--- Перехватываем вызовы turn.
local originalTurn = robot.turn
robot.turn = function(clockwice)
    local ret = originalTurn(clockwice)
    if ret then
        liblps.currentRotation = Rotation.rotate(liblps.currentRotation, clockwice)
    end
    return ret
end

return liblps
