--- @class filesystem
local filesystem = {}

--- Closes an open file descriptor with the specified handle.
--- @param handle userdata
--- @retrun 
function filesystem.close(handle)
end

--- Returns whether an object exists at the specified absolute path in the file system.
--- @param path string
--- @retrun boolean
function filesystem.exists(path)
end

--- some table named fsnode

--- Get the current label of the drive.
--- @retrun string
function filesystem.getLabel()
end

--- Returns whether the object at the specified absolute path in the file system is a directory.
--- @param path string
--- @retrun boolean
function filesystem.isDirectory(path)
end

--- Returns whether the file system is read-only.
--- @retrun boolean
function filesystem.isReadOnly()
end

--- Returns the (real world) timestamp of when the object at the specified absolute path in the file system was modified.
--- @param path string
--- @retrun number
function filesystem.lastModified(path)
end

--- Returns a list of names of objects in the directory at the specified absolute path in the file system.
--- @param path string
--- @retrun table
function filesystem.list(path)
end

--- Creates a directory at the specified absolute path in the file system. Creates parent directories, if necessary.
--- @param path string
--- @retrun boolean
function filesystem.makeDirectory(path)
end

--- Opens a new file descriptor and returns its handle.
--- @param path string
--- @param mode string?='r'
--- @retrun userdata
function filesystem.open(path, mode)
end

--- Reads up to the specified amount of data from an open file descriptor with the specified handle. Returns nil when EOF is reached.
--- @param handle userdata
--- @param count number
--- @retrun string or nil
function filesystem.read(handle, count)
end

--- Removes the object at the specified absolute path in the file system.
--- @param path string
--- @retrun boolean
function filesystem.remove(path)
end

--- Renames/moves an object from the first specified absolute path in the file system to the second.
--- @param from string
--- @param to string
--- @retrun boolean
function filesystem.rename(from, to)
end

--- Seeks in an open file descriptor with the specified handle. Returns the new pointer position.
--- @param handle userdata
--- @param whence string
--- @param offset number
--- @retrun number
function filesystem.seek(handle, whence, offset)
end

--- Sets the label of the drive. Returns the new value, which may be truncated.
--- @param value string
--- @retrun string
function filesystem.setLabel(value)
end

--- Returns the size of the object at the specified absolute path in the file system.
--- @param path string
--- @retrun number
function filesystem.size(path)
end

--- The overall capacity of the file system, in bytes.
--- @retrun number
function filesystem.spaceTotal()
end

--- The currently used capacity of the file system, in bytes.
--- @retrun number
function filesystem.spaceUsed()
end

--- Writes the specified data to an open file descriptor with the specified handle.
--- @param handle userdata
--- @param value string
--- @retrun boolean
function filesystem.write(handle, value)
end

return filesystem
