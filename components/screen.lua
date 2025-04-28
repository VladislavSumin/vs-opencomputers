--- @class screen
local screen = {}

--- The aspect ratio of the screen. For multi-block screens this is the number of blocks, horizontal and vertical.
--- @retrun number, number
function screen.getAspectRatio()
end

--- The list of keyboards attached to the screen.
--- @retrun table
function screen.getKeyboards()
end

--- Returns whether the screen is currently on.
--- @retrun boolean
function screen.isOn()
end

--- Returns whether the screen is in high precision mode (sub-pixel mouse event positions).
--- @retrun boolean
function screen.isPrecise()
end

--- Set whether to use high precision mode (sub-pixel mouse event positions).
--- @param enabled boolean
--- @retrun boolean
function screen.setPrecise(enabled)
end

--- Turns off the screen. Returns whether the state changed, and whether it is now on.
--- @retrun boolean
function screen.turnOff()
end

--- Turns the screen on. Returns whether the state changed, and whether it is now on.
--- @retrun boolean
function screen.turnOn()
end

return screen
