--- @class redstone
local redstone = {}

--- Fewer params returns set of inputs
--- @param side number
--- @param color number?
--- @retrun number or table
function redstone.getBundledInput(side, color)
end

--- Fewer params returns set of outputs
--- @param side number
--- @param color number?
--- @retrun number or table
function redstone.getBundledOutput(side, color)
end

--- Get the comparator input on the specified side.
--- @param side number
--- @retrun number
function redstone.getComparatorInput(side)
end

--- Get the redstone input (all sides, or optionally on the specified side)
--- @param side number
--- @retrun number or table
function redstone.getInput(side)
end

--- Get the redstone output (all sides, or optionally on the specified side)
--- @param side number
--- @retrun number or table
function redstone.getOutput(side)
end

--- Get the current wake-up threshold.
--- @retrun number
function redstone.getWakeThreshold()
end

--- Get the currently set wireless redstone frequency.
--- @retrun number
function redstone.getWirelessFrequency()
end

--- Get the wireless redstone input.
--- @retrun number
function redstone.getWirelessInput()
end

--- Get the wireless redstone output.
--- @retrun boolean
function redstone.getWirelessOutput()
end

---  Fewer params to assign set of outputs. Returns previous values
--- @param side number
--- @param color number?
--- @param value number= or table
--- @retrun number or table
function redstone.setBundledOutput(side, color, value)
end

---  Set the redstone output (all sides, or optionally on the specified side). Returns previous values
--- @param side number
--- @param value number= or table
--- @retrun number or table
function redstone.setOutput(side, value)
end

--- Set the wake-up threshold.
--- @param threshold number
--- @retrun number
function redstone.setWakeThreshold(threshold)
end

--- Set the wireless redstone frequency to use.
--- @param frequency number
--- @retrun number
function redstone.setWirelessFrequency(frequency)
end

--- Set the wireless redstone output.
--- @param value boolean
--- @retrun boolean
function redstone.setWirelessOutput(value)
end

return redstone
