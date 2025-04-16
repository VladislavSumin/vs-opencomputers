--- Набор полезных расширений для unit тестирования.

local libtest = {}

function libtest.assertEquals(expected, actual)
    if expected ~= actual then
        -- level = 2 нужен что бы в стеке было место вызова этой функции а не сама эта функция.
        error("Equals assertion failed:\n\tExpected: " .. expected .. "\n\tActual: " .. actual, 2)
    end
end

return function()
    for name, method in pairs(libtest) do
        -- Регистрируем методы в глобальной таблице что бы упростить синтаксис их вызова.
        _G[name] = method
    end
end
