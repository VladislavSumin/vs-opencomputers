local test = require("libtest")
local libluadoc = require("libluadoc")

function checkParameterToDocTest()
    local param = libluadoc.Parameter:new("name", "number", false, "3")
    test.assertEquals(
        "--- @param name number=3",
        param:toDoc()
    )
end

function checkOptionalParameterToDocTest()
    local param = libluadoc.Parameter:new("name", "number", true, "3")
    test.assertEquals(
        "--- @param name number?=3",
        param:toDoc()
    )
end
