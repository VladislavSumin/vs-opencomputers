--- @class robot
local robot = {}

--- Compare the block on the specified side with the one in the selected slot. Returns true if equal.
--- @param side number
--- @param fuzzy boolean?=false
--- @retrun boolean
function robot.compare(side, fuzzy)
end

--- Compare the fluid in the selected tank with the fluid in the specified tank on the specified side. Returns true if equal.
--- @param side number= 
--- @param tank number?
--- @retrun boolean
function robot.compareFluid(side, tank)
end

--- Compares the fluids in the selected and the specified tank. Returns true if equal.
--- @param index number
--- @retrun boolean
function robot.compareFluidTo(index)
end

--- Compare the contents of the selected slot to the contents of the specified slot.
--- @param otherSlot number
--- @param checkNBT boolean?=false
--- @retrun boolean
function robot.compareTo(otherSlot, checkNBT)
end

--- Get the number of items in the specified slot, otherwise in the selected slot.
--- @param slot number
--- @retrun number
function robot.count(slot)
end

--- Checks the contents of the block on the specified sides and returns the findings.
--- @param side number
--- @retrun boolean, string
function robot.detect(side)
end

--- Drains the specified amount of fluid from the specified side. Returns the amount drained, or an error message.
--- @param side boolean
--- @param amount number?=1000
--- @retrun boolean, number or string
function robot.drain(side, amount)
end

--- Drops items from the selected slot towards the specified side.
--- @param side number
--- @param count number?=64
--- @retrun boolean
function robot.drop(side, count)
end

--- Get the durability of the currently equipped tool.
--- @retrun number
function robot.durability()
end

--- Eject the specified amount of fluid to the specified side. Returns the amount ejected or an error message.
--- @param side number
--- @param amount number?=1000
--- @retrun boolean, number of string
function robot.fill(side, amount)
end

--- Get the current color of the activity light as an integer encoded RGB value (0xRRGGBB).
--- @retrun number
function robot.getLightColor()
end

--- The size of this device's internal inventory.
--- @retrun number
function robot.inventorySize()
end

--- Move in the specified direction.
--- @param direction number
--- @retrun boolean
function robot.move(direction)
end

--- Get the name of the agent.
--- @retrun string
function robot.name()
end

--- Place a block towards the specified side. The `face' allows a more precise click calibration, and is relative to the targeted blockspace.
--- @param side number
--- @param face number?=side
--- @param sneaky boolean?=false
--- @retrun boolean
function robot.place(side, face, sneaky)
end

--- Get the currently selected slot; set the selected slot if specified.
--- @param slot number
--- @retrun number
function robot.select(slot)
end

--- Select a tank and/or get the number of the currently selected tank.
--- @param index number
--- @retrun number
function robot.selectTank(index)
end

--- Set the color of the activity light to the specified integer encoded RGB value (0xRRGGBB).
--- @param value number
--- @retrun number
function robot.setLightColor(value)
end

--- Get the remaining space in the specified slot, otherwise in the selected slot.
--- @param slot number
--- @retrun number
function robot.space(slot)
end

--- Suck up items from the specified side.
--- @param side number
--- @param count number?=64
--- @retrun boolean
function robot.suck(side, count)
end

--- Perform a 'left click' towards the specified side. The `face' allows a more precise click calibration, and is relative to the targeted blockspace.
--- @param side number
--- @param face number?=side
--- @param sneaky boolean?=false
--- @retrun boolean, string
function robot.swing(side, face, sneaky)
end

--- The number of tanks installed in the device.
--- @retrun number
function robot.tankCount()
end

--- Get the fluid amount in the specified or selected tank.
--- @param index number
--- @retrun number
function robot.tankLevel(index)
end

--- Get the remaining fluid capacity in the specified or selected tank.
--- @param index number
--- @retrun number
function robot.tankSpace(index)
end

--- Move the specified amount of fluid from the selected tank into the specified tank.
--- @param index number
--- @param count number?=1000
--- @retrun boolean
function robot.transferFluidTo(index, count)
end

--- Move up to the specified amount of items from the selected slot into the specified slot.
--- @param toSlot number
--- @param amount number?
--- @retrun boolean
function robot.transferTo(toSlot, amount)
end

--- Rotate in the specified direction.
--- @param clockwise boolean
--- @retrun boolean
function robot.turn(clockwise)
end

--- Perform a 'right click' towards the specified side. The `face' allows a more precise click calibration, and is relative to the targeted blockspace.
--- @param side number
--- @param face number?=side
--- @param sneaky boolean?=false
--- @param duration number?=0
--- @retrun boolean, string
function robot.use(side, face, sneaky, duration)
end

return robot
