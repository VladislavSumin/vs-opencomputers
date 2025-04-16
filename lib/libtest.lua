--- Набор полезных расширений для unit тестирования.

local libtest = {}

function libtest.assertEquals(expected, actual)
    assert(
        expected == actual,
        "Equals assertion failed:\n\tExpected: " .. expected .. "\n\tActual: " .. actual
    )
end

return function()
    for name, method in pairs(libtest) do
        _G[name] = method
    end
end
