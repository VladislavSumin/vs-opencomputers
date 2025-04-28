--- @class computer
local computer = {}

--- Plays a tone, useful to alert users via audible feedback.
--- @param frequency string= or number
--- @param duration number?
--- @retrun 
function computer.beep(frequency, duration)
end

--- Collect information on all connected devices.
--- @retrun table
function computer.getDeviceInfo()
end

--- Returns a map of program name to disk label for known programs.
--- @retrun table
function computer.getProgramLocations()
end

--- Returns whether the computer is running.
--- @retrun boolean
function computer.isRunning()
end

--- Starts the computer. Returns true if the state changed.
--- @retrun boolean
function computer.start()
end

--- Stops the computer. Returns true if the state changed.
--- @retrun boolean
function computer.stop()
end

return computer
