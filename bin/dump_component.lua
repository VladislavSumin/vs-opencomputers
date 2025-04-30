-- Утилита для дампа api компонентов в виде lua прототипов.
-- Используется для получения подсказок в студии.
-- Компоненты в "components" сгенерированы этой тулзой.

local SPLIT_FUNCTION_REFEX = "^function%((.*)%):?(.*) %-%- (.*)$"
local ARGS_FUNCTION_REFEX = "(%[?,? ?)([a-zA-Z0-9_]+): ?([a-z]+)=?([^,%]%[]*)"

local component = require("component")
local shell = require("shell")
local libluadoc = require("libluadoc")

-- Парсим аргументы
local args = shell.parse(...)
local search = args[1]

-- Ищем первый компонент соответствующий фильтру
local componentAdress = nil
local componentName = nil
for adress, name in component.list(search) do
    componentAdress = adress
    componentName = name
    break
end
if type(componentAdress) == "nil" then
    error(string.format("component %s not found", search))
end

print("--- @class " .. componentName)
print("local " .. componentName .. " = {}")
print()

local proxy = component.proxy(componentAdress)

-- Предворительно отсортируем ключи что бы вывод всегда был одинаковым.
local keys = {}
for k in pairs(proxy) do
    table.insert(keys, k)
end
table.sort(keys)

-- Итерируемся по всем методам компонента
for _, methodName in ipairs(keys) do
    local method = proxy[methodName]
    local memberType = type(method)
    if memberType == "table" or memberType == "function" then
        local doc = component.doc(componentAdress, methodName) or tostring(proxy[methodName])

        if string.find(doc, "table: 0x") ~= nil then
            print("--- some table named " .. methodName)
            print()
            goto continue
        end

        local allArguments, returnType, comment = string.match(doc, SPLIT_FUNCTION_REFEX)

        local params = {}

        for data, name --[[string]], default, defaultValue in string.gmatch(allArguments, ARGS_FUNCTION_REFEX) do
            local isOptional = data == "[, "
            local param = libluadoc.Parameter:new(name, default, isOptional, defaultValue)
            table.insert(params, param)
        end

        local method = libluadoc.Method:new(methodName, params, returnType, comment)
        print(method:toDeclarationWithDoc(componentName))
        print()
        ::continue::
    end
end

print("return " .. componentName)
