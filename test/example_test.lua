local test = require("libtest")

function goodTest()
    print("Good test")
    test.assertEquals(4, 2 + 2)
end

function failingTest()
    print("Bad test")
    test.assertEquals(4, 1 + 2)
end
