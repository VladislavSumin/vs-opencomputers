-- Содержит описание lua типов для реализации кодогенерации

local libclass = require("libclass")

local libluadoc = {}

-------------------------------------------------------------------------------
--                               Parameter                                   --
-------------------------------------------------------------------------------

--- @class Parameter: Object
--- @field name string имя параметра
--- @field type string тип параметра
--- @field isOptional boolean?=false является ли параметер опциональным
--- @field defaultValue string? значение параметра по умолчанию
local Parameter = libclass.Object:extend()

--- @private
function Parameter:initialize(name, type, isOptional, defaultValue)
    self.name = name
    self.type = type
    self.isOptional = isOptional or false
    self.defaultValue = defaultValue
end

--- Переводит параметер в строку документации.
--- @return string
function Parameter:toDoc()
    local optional = self.isOptional and "?" or ""
    local default = (self.defaultValue ~= nil and self.defaultValue ~= "") and "=" .. self.defaultValue or ""
    return string.format("--- @param %s %s%s%s", self.name, self.type, optional, default)
end

-------------------------------------------------------------------------------
--                                 Method                                    --
-------------------------------------------------------------------------------

--- @class Method: Object
--- @field name string имя метода
--- @field params Parameter[] параметры метода
--- @field returnType string возвращаемое значение
--- @field doc string документация метода
local Method = libclass.Object:extend()

--- @private
function Method:initialize(name, params, returnType, doc)
    self.name = name
    self.params = params
    self.returnType = returnType
    self.doc = doc
end

function Method:toDoc()
    local doc = "--- " .. self.doc .. "\n"
    for _, m in ipairs(self.params) do
        doc = doc .. m:toDoc() .. "\n"
    end
    doc = doc .. "--- @retrun " .. self.returnType
    return doc
end

--- @param parent string? опцниональный параметер родителя функции
function Method:toDeclaration(parent)
    local declaration = "function "
    if parent then
        declaration = declaration .. parent .. "."
    end
    declaration = declaration .. self.name .. "("
    for i, p in ipairs(self.params) do
        if i > 1 then
            declaration = declaration .. ", "
        end
        declaration = declaration .. p.name
    end
    declaration = declaration .. ")\n"
    declaration = declaration .. "end"
    return declaration
end

--- @param parent string? опцниональный параметер родителя функции
function Method:toDeclarationWithDoc(parent)
    return self:toDoc() .. "\n" .. self:toDeclaration(parent)
end

function Method:__tostring()
    return self:toDeclarationWithDoc()
end

-------------------------------------------------------------------------------

libluadoc.Parameter = Parameter
libluadoc.Method = Method

return libluadoc
