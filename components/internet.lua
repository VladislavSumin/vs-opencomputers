--- @class internet
local internet = {}

--- Opens a new TCP connection. Returns the handle of the connection.
--- @param address string
--- @param port number?
--- @retrun userdata
function internet.connect(address, port)
end

--- Returns whether HTTP requests can be made (config setting).
--- @retrun boolean
function internet.isHttpEnabled()
end

--- Returns whether TCP connections can be made (config setting).
--- @retrun boolean
function internet.isTcpEnabled()
end

--- Starts an HTTP request. If this returns true, further results will be pushed using `http_response` signals.
--- @param url string
--- @param postData string?
--- @param headers table?
--- @param method string?
--- @retrun userdata
function internet.request(url, postData, headers, method)
end

return internet
