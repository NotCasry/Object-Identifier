local Players = game:GetService("Players")

function GetMouse()
	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()
	
	return Mouse
end

function GetMouseRay(Mouse, FilterType, Filters, DirectionLength)
	local UnitRay = Mouse.UnitRay
	local Origin = UnitRay.Origin
	local Direction = UnitRay.Direction * DirectionLength
	
	local RaycastParams = RaycastParams.new()
	RaycastParams.FilterType = FilterType
	RaycastParams.FilterDescendantsInstances = Filters
	
	local Result = workspace:Raycast(Origin, Direction, RaycastParams)
	
	if Result and not Result.Instance then
		return {
			RaycastOrigin = UnitRay.Origin;
			RaycastDirection = UnitRay.Direction * DirectionLength;
			RaycastPosition = Result.Position;
			RaycastNormal = Result.Normal;
			RaycastDistance = Result.Distance;
		}
	elseif Result and Result.Instance then
		return {
			RaycastOrigin = UnitRay.Origin;
			RaycastDirection = UnitRay.Direction * DirectionLength;
			RaycastInstance = Result.Instance;
			RaycastPosition = Result.Position;
			RaycastNormal = Result.Normal;
			RaycastDistance = Result.Distance;
			RaycastMaterial = Result.Material;
		}
	elseif not Result then
		return {
			RaycastOrigin = nil;
			RaycastDirection = nil;
			RaycastInstance = nil;
			RaycastPosition = nil;
			RaycastNormal = nil;
			RaycastDistance = nil;
			RaycastMaterial = nil;
		}
	end
end

local gui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));

gui.Name = "analyzepart"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = true

local textlabel = Instance.new("TextLabel", gui)
textlabel.TextWrapped = true
textlabel.TextScaled = true
textlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textlabel.TextSize = 14
textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textlabel.Size = UDim2.new(0, 200, 0, 50)
textlabel.Text = "None"
textlabel.Name = "part_name_label"
textlabel.Font = Enum.Font.Ubuntu
textlabel.BackgroundTransparency = 1
textlabel.Position = UDim2.new(0.42403629422187805, 0, 0.8848560452461243, 0);

spawn(function()
    while task.wait() do
        if not Players.LocalPlayer.PlayerGui:FindFirstChild("analyzepart") then
            local gui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));

            gui.Name = "analyzepart"
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.ResetOnSpawn = true

            local textlabel = Instance.new("TextLabel", gui)
            textlabel.TextWrapped = true
            textlabel.TextScaled = true
            textlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textlabel.TextSize = 14
            textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textlabel.Size = UDim2.new(0, 200, 0, 50)
            textlabel.Text = "None"
            textlabel.Name = "part_name_label"
            textlabel.Font = Enum.Font.Ubuntu
            textlabel.BackgroundTransparency = 1
            textlabel.Position = UDim2.new(0.42403629422187805, 0, 0.8848560452461243, 0);
        end
    end
end)

spawn(function()
    while task.wait() do
        local mouse_ = GetMouse()
        local m = GetMouseRay(mouse_, Enum.RaycastFilterType.Blacklist, {}, 10000)

        if Players.LocalPlayer.PlayerGui:FindFirstChild("analyzepart") ~= nil and m.RaycastInstance ~= nil then
            Players.LocalPlayer.PlayerGui:FindFirstChild("analyzepart").part_name_label.Text = m.RaycastInstance.Name
        end
    end
end)
