local test = require("libtest")
local libcommand = require("libcommand")


--- @return CommandProcessor, [string]
local function makeTestProcessor()
    local result = { "" }

    local functions = {
        tna = function()
            result[1] = result[1] .. "tna"
        end,

        twa = function(arg1, arg2)
            result[1] = result[1] .. "twa" .. arg1 .. arg2
        end,
    }

    local processor = libcommand.CommandProcessor:new(functions)
    return processor, result
end

function testSingleCommandNoArgs()
    local processor, result = makeTestProcessor()
    processor:parse("tna"):exec()
    test.assertEquals("tna", result[1])
end

function testSingleCommandWithArgs()
    local processor, result = makeTestProcessor()
    processor:parse("twa hello world"):exec()
    test.assertEquals("twahelloworld", result[1])
end
