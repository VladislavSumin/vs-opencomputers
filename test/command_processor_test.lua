local test = require("libtest")
local libcommand = require("libcommand")

function testSingleCommandsNoArgs()
    local result = ""
    local functions = {
        testFunctionNoArgs = function()
            result = result .. "t"
        end
    }
    local processor = libcommand.CommandProcessor:new(functions)
    processor:parse("testFunctionNoArgs"):exec()

    test.assertEquals("t", result)
end
