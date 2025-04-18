-- Набор полезных расширений для unit тестирования.

local libtest = {}

function libtest.assertEquals(expected, actual)
    if expected ~= actual then
        -- level = 2 нужен что бы в стеке было место вызова этой функции а не сама эта функция.
        error("Equals assertion failed:\n\tExpected: " .. expected .. "\n\tActual: " .. actual, 2)
    end
end

function libtest.assertTrue(value)
    if not value then
        error("True assertion failed:\n\tExpected: true\n\tActual: false", 2)
    end
end

function libtest.assertFalse(value)
    if value then
        error("False assertion failed:\n\tExpected: false\n\tActual: true", 2)
    end
end

function libtest.assertNotNil(value)
    if value == nil then
        error("Not nil assertion failed:\n\tExpected: not nil\n\tActual: nil", 2)
    end
end

function libtest.assertNil(value)
    if value ~= nil then
        error("Nil assertion failed:\n\tExpected: nil\n\tActual: " .. tostring(value), 2)
    end
end

return libtest
