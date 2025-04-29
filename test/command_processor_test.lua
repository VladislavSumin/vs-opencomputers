local test = require("libtest")
local libcommand = require("libcommand")

function testSingleCommandNoArgs()
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

function testSingleCommandWithArgs()
    local result = ""
    local functions = {
        testFunctionWithArgs = function(arg1, arg2)
            result = result .. "t" .. arg1 .. arg2
        end
    }
    local processor = libcommand.CommandProcessor:new(functions)
    processor:parse("testFunctionWithArgs hello world"):exec()

    test.assertEquals("thelloworld", result)
end
