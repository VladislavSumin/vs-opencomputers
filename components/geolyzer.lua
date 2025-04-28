--- @class geolyzer
local geolyzer = {}

--- Get some information on a directly adjacent block.
--- @param side number
--- @param options table
--- @retrun table
function geolyzer.analyze(side, options)
end

--- Returns whether there is a clear line of sight to the sky directly above.
--- @retrun boolean
function geolyzer.canSeeSky()
end

--- Checks the contents of the block on the specified sides and returns the findings.
--- @param side number
--- @retrun boolean, string
function geolyzer.detect(side)
end

--- Return whether the sun is currently visible directly above.
--- @retrun boolean
function geolyzer.isSunVisible()
end

--- Analyzes the density of the column at the specified relative coordinates.
--- @param x number
--- @param z number
--- @param y number?
--- @param w number
--- @param d number
--- @param h number
--- @param ignoreReplaceable boolean?=|options:table
--- @retrun table
function geolyzer.scan(x, z, y, w, d, h, ignoreReplaceable)
end

--- Returns GregTech underground fluids information
--- @retrun table
function geolyzer.scanUndergroundFluids()
end

--- Store an item stack representation of the block on the specified side in a database component.
--- @param side number
--- @param dbAddress string
--- @param dbSlot number
--- @retrun boolean
function geolyzer.store(side, dbAddress, dbSlot)
end

return geolyzer
