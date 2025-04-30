-- Утилита для дампа api компонентов в виде lua прототипов.
-- Используется для получения подсказок в студии.
-- Компоненты в "components" сгенерированы этой тулзой.
-- Дампит сразу все компоненты

local component = require("component")
local shell = require("shell")

for adress, name in component.list() do
    shell.execute("dump_component " .. name .. " >" .. name .. ".lua")
end
