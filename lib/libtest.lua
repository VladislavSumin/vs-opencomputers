--- Набор полезных расширений для unit тестирования.

function assertEquals(expected, actual)
    assert(
        expected == actual,
        "Equals assertion failed:\n\tExpected: " .. expected .. "\n\tActual: " .. actual
    )
end
