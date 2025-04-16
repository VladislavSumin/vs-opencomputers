local test = require("libtest")
local libcoord = require("libcoord")
local WorldCoord = libcoord.WorldCoord

function createWorldCoordTest()
    local wc = WorldCoord:new(1, 2, 3)
    test.assertEquals(1, wc.x)
    test.assertEquals(2, wc.y)
    test.assertEquals(3, wc.z)
end
