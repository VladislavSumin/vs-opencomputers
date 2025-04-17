local test = require("libtest")
local libcoord = require("libcoord")
local Rotation = libcoord.Rotation

function oppositeSideTest()
    local n = Rotation.north
    local e = Rotation.east
    local s = Rotation.south
    local w = Rotation.west

    test.assertEquals(s, Rotation.opposite(n))
    test.assertEquals(n, Rotation.opposite(s))
    test.assertEquals(e, Rotation.opposite(w))
    test.assertEquals(w, Rotation.opposite(e))
end

function rotationTest()
    local n = Rotation.north
    local e = Rotation.east
    local s = Rotation.south
    local w = Rotation.west

    -- Проверка поворота по часовой стрелке
    test.assertEquals(e, Rotation.rotate(n, true))
    test.assertEquals(s, Rotation.rotate(e, true))
    test.assertEquals(w, Rotation.rotate(s, true))
    test.assertEquals(n, Rotation.rotate(w, true))

    -- Проверка поворота против часовой стрелки
    test.assertEquals(w, Rotation.rotate(n, false))
    test.assertEquals(s, Rotation.rotate(w, false))
    test.assertEquals(e, Rotation.rotate(s, false))
    test.assertEquals(n, Rotation.rotate(e, false))
end
