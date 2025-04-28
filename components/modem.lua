--- @class modem
local modem = {}

--- Broadcasts the specified data on the specified port.
--- @param port number
--- @retrun 
function modem.broadcast(port)
end

--- Closes the specified port (default: all ports). Returns true if ports were closed.
--- @param port number
--- @retrun boolean
function modem.close(port)
end

--- Get the signal strength (range) used when sending messages.
--- @retrun number
function modem.getStrength()
end

--- Get the current wake-up message.
--- @retrun string, boolean
function modem.getWakeMessage()
end

--- Whether the specified port is open.
--- @param port number
--- @retrun boolean
function modem.isOpen(port)
end

--- Whether this card has wired networking capability.
--- @retrun boolean
function modem.isWired()
end

--- Whether this card has wireless networking capability.
--- @retrun boolean
function modem.isWireless()
end

--- Gets the maximum packet size (config setting).
--- @retrun number
function modem.maxPacketSize()
end

--- Opens the specified port. Returns true if the port was opened.
--- @param port number
--- @retrun boolean
function modem.open(port)
end

--- Sends the specified data to the specified target.
--- @param address string
--- @param port number
--- @retrun 
function modem.send(address, port)
end

--- Set the signal strength (range) used when sending messages.
--- @param strength number
--- @retrun number
function modem.setStrength(strength)
end

--- Set the wake-up message and whether to ignore additional data/parameters.
--- @param message string
--- @param fuzzy boolean?
--- @retrun string
function modem.setWakeMessage(message, fuzzy)
end

return modem
