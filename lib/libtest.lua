-- Набор полезных расширений для unit тестирования.

local libtest = {}

function libtest.assertEquals(expected, actual)
    if expected ~= actual then
        -- level = 2 нужен что бы в стеке было место вызова этой функции а не сама эта функция.
        error("Equals assertion failed:\n\tExpected: " .. expected .. "\n\tActual: " .. actual, 2)
    end
end

return libtest
