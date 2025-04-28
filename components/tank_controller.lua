--- @class tank_controller
local tank_controller = {}

--- Transfers fluid from a tank in the selected inventory slot to the selected tank.
--- @param amount number
--- @retrun boolean
function tank_controller.drain(amount)
end

--- Transfers fluid from the selected tank to a tank in the selected inventory slot.
--- @param amount number
--- @retrun boolean
function tank_controller.fill(amount)
end

--- Get a description of the fluid in the tank in the specified slot or the selected slot.
--- @param tank number
--- @retrun table
function tank_controller.getFluidInInternalTank(tank)
end

--- Get a description of the fluid in the the specified tank on the specified side.
--- @param side number= 
--- @param tank number?
--- @retrun table
function tank_controller.getFluidInTank(side, tank)
end

--- Get a description of the fluid in the tank item in the specified slot or the selected slot.
--- @param slot number
--- @retrun table
function tank_controller.getFluidInTankInSlot(slot)
end

--- Get the capacity of the specified tank on the specified side.
--- @param side number= 
--- @param tank number?
--- @retrun number
function tank_controller.getTankCapacity(side, tank)
end

--- Get the capacity of the tank item in the specified slot of the robot or the selected slot.
--- @param slot number
--- @retrun number
function tank_controller.getTankCapacityInSlot(slot)
end

--- Get the number of tanks available on the specified side.
--- @param side number
--- @retrun number
function tank_controller.getTankCount(side)
end

--- Get the amount of fluid in the specified tank on the specified side.
--- @param side number= 
--- @param tank number?
--- @retrun number
function tank_controller.getTankLevel(side, tank)
end

--- Get the amount of fluid in the tank item in the specified slot or the selected slot.
--- @param slot number
--- @retrun number
function tank_controller.getTankLevelInSlot(slot)
end

return tank_controller
