local players = game.Players
local localPlayer = game.Players.LocalPlayer
local ts = game:GetService("TeleportService")
local uis = game:GetService("UserInputService")
-- Function to add ESP to a player's character
local function addESP(player)
	if player == localPlayer then
		return -- Skip adding ESP for the local player
	end
	local char = player.Character or player.CharacterAdded:Wait() -- Ensure the character exists
	local rootPart = char:WaitForChild("HumanoidRootPart") -- Wait for the root part to load
	
	-- highlight
	local highlight = Instance.new("Highlight")
	highlight.Parent = char
	highlight.OutlineTransparency = 1
	highlight.Adornee = char
	highlight.FillTransparency = 0.5
	

	-- Create the BillboardGui
	local nameEsp = Instance.new("BillboardGui")
	nameEsp.Parent = rootPart
	nameEsp.Size = UDim2.new(4, 0, 1, 0) -- Scale size (width = 2x, height = 0.5x)
	nameEsp.Adornee = rootPart -- Attach it to the HumanoidRootPart
	nameEsp.StudsOffset = Vector3.new(0, 3, 0) -- Offset above the player's head
	nameEsp.AlwaysOnTop = true -- Ensure it appears above other objects
	
	-- Create the TextLabel
	local text = Instance.new("TextLabel")
	text.Parent = nameEsp
	text.Size = UDim2.new(1, 0, 1, 0) -- Fill the BillboardGui
	text.BackgroundTransparency = 1 -- Transparent background
	text.Text = player.Name -- Display the player's name
	text.TextColor3 = Color3.new(0, 0, 0) -- Red
	text.TextScaled = true -- Scale text to fit
	-- stroke
	local stroke = Instance.new("UIStroke")
	stroke.Parent = text
	stroke.Color = Color3.new(1,0,0)
	stroke.Thickness = 0.4
	
end

-- Add ESP for all players currently in the game
for _, player in pairs(players:GetPlayers()) do
	addESP(player)
end
-- Listen for keypress to teleport the local player back to the same game
uis.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
		ts:Teleport(game.PlaceId, localPlayer)
	end
end)

-- Add ESP for players who join the game in the future
players.PlayerAdded:Connect(function(player)
	addESP(player)
end)
