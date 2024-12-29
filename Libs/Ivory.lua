local Ivory = {}

Ivory.MoveTo = function(partToMove: Part, posToMoveTo: Vector3)
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")

	local Chat = function(msg: string)
		Players:Chat(msg)
	end

	local chra: Model = Players.LocalPlayer.Character

	repeat
		task.wait()
		chra = Players.LocalPlayer.Character
	until chra and chra:FindFirstChild("Humanoid")

	Chat("gear me 108158379") -- ivory to teleport on the server-side

	local root: BasePart = chra:WaitForChild("HumanoidRootPart", 5)
	local ivory: Tool = Players.LocalPlayer.Backpack:WaitForChild("IvoryPeriastron", 5) -- ping..

	if not ivory then
		secureerror("[\"IVORY MOVER\"] IvoryPeriastron not found in backpack!")
		return -- end script
	else
		-- prepare ivory
		ivory.Parent = chra
	end

	local TriggerIvory = function(ivory: Tool)
		ivory:WaitForChild("Remote", 5):FireServer(Enum.KeyCode.E)
	end

	local FakeAnchor = function(part: BasePart)
		local anchorTo = part.Position
		local grav = workspace.Gravity

		local connection
		return {
			Start = function()
				workspace.Gravity = 0
				connection = RunService.RenderStepped:Connect(function(deltaTime: number) 
					part.CFrame = CFrame.new(anchorTo)
				end)
			end,
			End = function()
				if connection then
					connection:Disconnect()
					workspace.Gravity = grav
				end
			end,
		}
	end

	-- ivory drift offsets dynamically calculated
	local offsetX = (partToMove.Size.X / 2) - (chra["Torso"].Size.X / 2)-- sdfgjjsdfghngfnddfgnj i give up.

	root.CFrame = CFrame.new(posToMoveTo) * CFrame.new(-offsetX, 0.2, 0) -- floating point error still..
	local anchor = FakeAnchor(root)
	anchor.Start()
	task.wait(0.2) -- TODO: make this more dynamic
	TriggerIvory(ivory)
	anchor.End()

	local looping = true
	spawn(function()
		while looping do
			task.wait()
			chra['Humanoid']:ChangeState(11)
			root.CFrame = partToMove.CFrame * CFrame.new(-1*(partToMove.Size.X/2)-(chra['Torso'].Size.X/2), 0, 0)
		end
	end)

	spawn(function()
		while looping do
			task.wait(.1)
			Chat("unpunish me")
		end
	end)

	local connection = nil
	connection = chra.DescendantAdded:Connect(function(descendant: Instance)
		if descendant:IsA("Weld") or descendant:IsA("Snap") then
			connection:Disconnect()
			looping = false
			TriggerIvory(ivory)
		end
	end)
end

return Ivory
