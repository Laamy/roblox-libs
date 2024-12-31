-- NOTE: u can do this anyways but this is for a project im working on
local RBXScriptSignal = {}
RBXScriptSignal.__index = RBXScriptSignal

function RBXScriptSignal.new()
	local self = setmetatable({}, RBXScriptSignal)
	self.connections = {}
    return self
end

function RBXScriptSignal:Connect(callback)
	local connection = { callback = callback, once = false }
	table.insert(self.connections, connection)
	return connection
end

function RBXScriptSignal:ConnectOnce(callback)
	local connection = { callback = callback, once = true }
	table.insert(self.connections, connection)
	return connection
end

function RBXScriptSignal:Wait()
	local result
	local connection = self:ConnectOnce(function(...)
		result = { ... }
	end)
	while not result do
		wait()
	end
	return unpack(result)
end

function RBXScriptSignal:Fire(...)
	for _, connection in ipairs(self.connections) do
		connection.callback(...)
		if connection.once then
			self:Disconnect(connection)
		end
	end
end

function RBXScriptSignal:Disconnect(connection)
	for i, conn in ipairs(self.connections) do
		if conn == connection then
			table.remove(self.connections, i)
			break
		end
	end
end

return RBXScriptSignal
