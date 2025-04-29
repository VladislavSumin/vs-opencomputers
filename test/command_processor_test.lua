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

function testMultipleCommandsNoArgs()
    local processor, result = makeTestProcessor()
    processor:parse("tna\ntna"):exec()
    test.assertEquals("tnatna", result[1])
end

function testMultipleCommandsNoArgsMultiline()
    local processor, result = makeTestProcessor()
    processor:parse([[
        tna
        tna
    ]]):exec()
    test.assertEquals("tnatna", result[1])
end

function testMultipleCommandsMultiline()
    local processor, result = makeTestProcessor()
    processor:parse([[
        twa t t3
        tna
    ]]):exec()
    test.assertEquals("twatt3tna", result[1])
end
