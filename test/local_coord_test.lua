local test = require("libtest")
local libcoord = require("libcoord")
local LocalCoord = libcoord.LocalCoord

function createLocalCoordTest()
    local lc = LocalCoord:new(1, 2, 3)
    test.assertEquals(1, lc.x)
    test.assertEquals(2, lc.y)
    test.assertEquals(3, lc.z)
end
