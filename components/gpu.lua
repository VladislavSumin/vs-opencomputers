--- @class gpu
local gpu = {}

--- allocates a new buffer with dimensions width*height (defaults to max resolution) and appends it to the buffer list. Returns the index of the new buffer and returns nil with an error message on failure. A buffer can be allocated even when there is no screen bound to this gpu. Index 0 is always reserved for the screen and thus the lowest index of an allocated buffer is always 1.
--- @param width number
--- @param height number
--- @retrun  number
function gpu.allocateBuffer(width, height)
end

--- Binds the GPU to the screen with the specified address and resets screen settings if `reset` is true.
--- @param address string
--- @param reset boolean?=true
--- @retrun boolean
function gpu.bind(address, reset)
end

--- bitblt from buffer to screen. All parameters are optional. Writes to `dst` page in rectangle `x, y, width, height`, defaults to the bound screen and its viewport. Reads data from `src` page at `fx, fy`, default is the active page from position 1, 1
--- @param dst number
--- @param col number
--- @param row number
--- @param width number
--- @param height number
--- @param src number
--- @param fromCol number
--- @param fromRow number
--- @retrun boolean
function gpu.bitblt(dst, col, row, width, height, src, fromCol, fromRow)
end

--- Returns an array of indexes of the allocated buffers
--- @retrun  number
function gpu.buffers()
end

--- Copies a portion of the screen from the specified location with the specified size by the specified translation.
--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param tx number
--- @param ty number
--- @retrun boolean
function gpu.copy(x, y, width, height, tx, ty)
end

--- Fills a portion of the screen at the specified position with the specified size with the specified character.
--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param char string
--- @retrun boolean
function gpu.fill(x, y, width, height, char)
end

--- Closes all buffers and returns the count. If the active buffer is closed, index moves to 0
--- @retrun  number
function gpu.freeAllBuffers()
end

--- Closes buffer at `index`. Returns true if a buffer closed. If the current buffer is closed, index moves to 0
--- @param index number
--- @retrun  boolean
function gpu.freeBuffer(index)
end

--- returns the total free memory not allocated to buffers. This does not include the screen.
--- @retrun  number
function gpu.freeMemory()
end

--- Get the value displayed on the screen at the specified index, as well as the foreground and background color. If the foreground or background is from the palette, returns the palette indices as fourth and fifth results, else nil, respectively.
--- @param x number
--- @param y number
--- @retrun string, number, number, number or nil, number or nil
function gpu.get(x, y)
end

--- returns the index of the currently selected buffer. 0 is reserved for the screen. Can return 0 even when there is no screen
--- @retrun  number
function gpu.getActiveBuffer()
end

--- Get the current background color and whether it's from the palette or not.
--- @retrun number, boolean
function gpu.getBackground()
end

--- returns the buffer size at index. Returns the screen resolution for index 0. returns nil for invalid indexes
--- @param index number
--- @retrun  number, number
function gpu.getBufferSize(index)
end

--- Returns the currently set color depth.
--- @retrun number
function gpu.getDepth()
end

--- Get the current foreground color and whether it's from the palette or not.
--- @retrun number, boolean
function gpu.getForeground()
end

--- Get the palette color at the specified palette index.
--- @param index number
--- @retrun number
function gpu.getPaletteColor(index)
end

--- Get the current screen resolution.
--- @retrun number, number
function gpu.getResolution()
end

--- Get the address of the screen the GPU is currently bound to.
--- @retrun string
function gpu.getScreen()
end

--- Get the current viewport resolution.
--- @retrun number, number
function gpu.getViewport()
end

--- Get the maximum supported color depth.
--- @retrun number
function gpu.maxDepth()
end

--- Get the maximum screen resolution.
--- @retrun number, number
function gpu.maxResolution()
end

--- Plots a string value to the screen at the specified position. Optionally writes the string vertically.
--- @param x number
--- @param y number
--- @param value string
--- @param vertical boolean?
--- @retrun boolean
function gpu.set(x, y, value, vertical)
end

--- Sets the active buffer to `index`. 1 is the first vram buffer and 0 is reserved for the screen. returns nil for invalid index (0 is always valid)
--- @param index number
--- @retrun  number
function gpu.setActiveBuffer(index)
end

--- Sets the background color to the specified value. Optionally takes an explicit palette index. Returns the old value and if it was from the palette its palette index.
--- @param value number
--- @param palette boolean?
--- @retrun number, number or nil
function gpu.setBackground(value, palette)
end

--- Set the color depth. Returns the previous value.
--- @param depth number
--- @retrun number
function gpu.setDepth(depth)
end

--- Sets the foreground color to the specified value. Optionally takes an explicit palette index. Returns the old value and if it was from the palette its palette index.
--- @param value number
--- @param palette boolean?
--- @retrun number, number or nil
function gpu.setForeground(value, palette)
end

--- Set the palette color at the specified palette index. Returns the previous value.
--- @param index number
--- @param color number
--- @retrun number
function gpu.setPaletteColor(index, color)
end

--- Set the screen resolution. Returns true if the resolution changed.
--- @param width number
--- @param height number
--- @retrun boolean
function gpu.setResolution(width, height)
end

--- Set the viewport resolution. Cannot exceed the screen resolution. Returns true if the resolution changed.
--- @param width number
--- @param height number
--- @retrun boolean
function gpu.setViewport(width, height)
end

--- returns the total memory size of the gpu vram. This does not include the screen.
--- @retrun  number
function gpu.totalMemory()
end

return gpu
