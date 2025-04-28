--- @class eeprom
local eeprom = {}

--- Get the currently stored byte array.
--- @retrun string
function eeprom.get()
end

--- Get the checksum of the data on this EEPROM.
--- @retrun string
function eeprom.getChecksum()
end

--- Get the currently stored byte array.
--- @retrun string
function eeprom.getData()
end

--- Get the storage capacity of this EEPROM.
--- @retrun number
function eeprom.getDataSize()
end

--- Get the label of the EEPROM.
--- @retrun string
function eeprom.getLabel()
end

--- Get the storage capacity of this EEPROM.
--- @retrun number
function eeprom.getSize()
end

--- Make this EEPROM readonly if it isn't already. This process cannot be reversed!
--- @param checksum string
--- @retrun boolean
function eeprom.makeReadonly(checksum)
end

--- Overwrite the currently stored byte array.
--- @param data string
--- @retrun 
function eeprom.set(data)
end

--- Overwrite the currently stored byte array.
--- @param data string
--- @retrun 
function eeprom.setData(data)
end

--- Set the label of the EEPROM.
--- @param data string
--- @retrun string
function eeprom.setLabel(data)
end

return eeprom
