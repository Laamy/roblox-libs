local bloodfruit: ImageButton = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RightPanel.Inventory.List.Bloodfruit.ImageButton

--InputObject clone
local InputObject = {}
InputObject.__index = InputObject

local function InputObject.new(keyCode, userInputState, userInputType)
    local self = setmetatable({}, InputObject)
    self.Delta = Vector3.zero
    self.KeyCode = keyCode or Enum.KeyCode.MouseLeftButton
    self.Position = Vector3.zero
    self.UserInputState = userInputState or Enum.UserInputState.Begin
    self.UserInputType = userInputType or Enum.UserInputType.MouseButton1
    return self
end

local function FireInput(obj, input: InputObject): ()
    for i,v in pairs(getconnections(obj.InputBegan)) do 
        v:Fire(input)
    end
end

FireInput(bloodfruit, InputObject.new())
