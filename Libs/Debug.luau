local Debug = {}
Debug.__index = Debug

function Debug.new(): ()
    local self = setmetatable({}, Debug)
    return self
end

type Table = {[any]: any}

function Debug.getraw(Fake): Table
    local __index = getrawmetatable(Fake).__index
    return getupvalue(__index, 1)
end

function Debug.require(Module): Table
    return Debug.GetModule(require(Module))
end

return Debug
