--[[puuror0]]

local LP = game.Players.LocalPlayer
local BP = LP.Backpack
local PG = LP.PlayerGui
local WS = workspace
local DB = true

pcall(function()
    if BP:FindFirstChild("Block") then
        local Tool = Instance.new("Tool")
        local Handle = BP.Block.Handle:Clone()
        local Outline = WS.GameStorage.Blocks.Block
        local Selection = PG.SelectionBox:Clone()

	for _, plr in pairs(BP:GetChildren()) do if plr.Name == "RanBlock" then DB = false end end
	if DB then Tool.Parent = BP end
	DB = true

	Tool.TextureId = "rbxassetid://13049842307"
        Tool.Name = "RanBlock"
        Tool.CanBeDropped = false
        Handle.Parent = Tool

        Tool.Activated:Connect(function()
            local directions = {0, -8, 0}

            local fire = {nil, Enum.NormalId.Top, LP.Character.HumanoidRootPart.Position + Vector3.new(directions[1],directions[2],directions[3])}
            game:GetService("Players").LocalPlayer.Backpack.Block.RemoteEvent:FireServer(fire[1], fire[2], fire[3])
        end)
        Tool.Equipped:Connect(function()
            Outline:Clone()
            Outline.CanCollide = false
            Outline.Anchored = true
            Outline.Transparency = 0.60
            Outline.BrickColor = BrickColor.new("Neon orange")
            Outline.Parent = WS.GameStorage.Blocks
            Selection.Adornee = Outline
            Selection.Parent = Outline
            while wait(0.001) do
                Outline.Position = LP.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, -8, 0)
            end
        end)
        Tool.Unequipped:Connect(function()
            Tool.TextureId = "rbxassetid://13049842307"
            Outline.Transparency = 1
            Selection.Adornee = nil
            Outline:Remove()
        end)
    else
        game.StarterGui:SetCore("SendNotification", {
            Title    = "Please wait until the round starts";
            Text     = "";
            Duration = 0.5;
        })    
    end
end)
