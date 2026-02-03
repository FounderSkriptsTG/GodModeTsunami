-- 🌊 ULTIMATE TSUNAMI SCRIPT 🌊
-- 📱 Delta Executor (Mobile/PC) ✅
-- 👑 Founder Scripts 👑
-- 📱 t.me/FounderScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local PathfindingService = game:GetService("PathfindingService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🛡️ Anti-Cheat Bypass 🛡️
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" then
        local name = self.Name:lower()
        if name:find("damage") or name:find("hurt") or name:find("kill") then
            return
        end
    end
    
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- 🎮 Variables 🎮
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootpart = character:WaitForChild("HumanoidRootPart")

local guiVisible = false
local features = {
    survivalMode = false,
    vipWalls = false,
    autoBrainrot = false,
    autoTwin = false,
    autoCoins = false,
    autoSpeed = false
}

-- 🌊 Survival Mode (Выживает 1-2 волны минимум) 🌊
local function survivalMode()
    humanoid.MaxHealth = 500
    humanoid.Health = 500
    
    spawn(function()
        while features.survivalMode and character.Parent do
            wait(0.1)
            if humanoid.Health < 100 then
                humanoid.Health = 500
            end
            
            -- Удаляем tsunami damage
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave") then
                    if obj:IsA("BasePart") then
                        obj.CanCollide = false
                    end
                end
            end
        end
    end)
end

-- 🧱 VIP Walls Remover 🧱
local function removeVIPWalls()
    spawn(function()
        while features.vipWalls do
            wait(0.3)
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("vip") or obj.Name:lower():find("wall") or obj.Name:lower():find("barrier") then
                    if obj:IsA("BasePart") then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                end
            end
        end
    end)
end

-- 🧠 Auto Brainrot 🧠
local function autoBrainrot()
    spawn(function()
        while features.autoBrainrot do
            wait(1)
            -- Ищем brainrot
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("brainrot") or obj.Name == "Brainrot" then
                    if obj:IsA("BasePart") and obj.Parent then
                        humanoid:MoveTo(obj.Position)
                        wait(0.5)
                    end
                end
            end
        end
    end)
end

-- 🏃‍♂️ Auto Twin to End 🏃‍♂️
local spawnPoint = Vector3.new(0, 50, 0) -- Конец карты
local isTsunamiActive = false

local function checkTsunami()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name:lower():find("tsunami") and obj:IsA("BasePart") then
            local dist = (obj.Position - rootpart.Position).Magnitude
            if dist < 200 then
                isTsunamiActive = true
            else
                isTsunamiActive = false
            end
            break
        end
    end
end)

local function autoTwin()
    spawn(function()
        while features.autoTwin do
            wait(0.5)
            checkTsunami()
            
            if not isTsunamiActive then
                humanoid:MoveTo(spawnPoint)
            end
        end
    end)
end

-- 💰 Auto Collect Coins 💰
local function autoCoins()
    spawn(function()
        while features.autoCoins do
            wait(0.2)
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("coin") or obj.Name:lower():find("money") then
                    if obj:IsA("BasePart") and obj.Parent then
                        humanoid:MoveTo(obj.Position)
                        firetouchinterest(rootpart, obj, 0)
                        firetouchinterest(rootpart, obj, 1)
                    end
                end
            end
        end
    end)
end

-- ⚡ Auto Speed Upgrade ⚡
local function autoSpeed()
    spawn(function()
        while features.autoSpeed do
            wait(2)
            -- Авто покупка speed (имитация кликов по кнопкам)
            local speedGui = PlayerGui:FindFirstChild("SpeedGui") or PlayerGui:FindFirstChild("Shop")
            if speedGui then
                for _, btn in pairs(speedGui:GetDescendants()) do
                    if btn:IsA("TextButton") and btn.Text:find("Speed") then
                        firesignal(btn.MouseButton1Click)
                    end
                end
            end
        end
    end)
end

-- 🎨 BEAUTIFUL GUI 🎨
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TsunamiUltimateGUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
MainFrame.Size = UDim2.new(0, 400, 0, 400)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Gradient
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🌊 TSUNAMI ULTIMATE 🌊"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextStrokeTransparency = 0.5

-- Toggle Buttons Frame
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Parent = MainFrame
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Position = UDim2.new(0.05, 0, 0.18, 0)
ButtonsFrame.Size = UDim2.new(0.9, 0, 0.7, 0)

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = ButtonsFrame
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.Padding = UDim.new(0, 8)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Credits
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Parent = MainFrame
CreditLabel.BackgroundTransparency = 1
CreditLabel.Position = UDim2.new(0, 0, 0.92, 0)
CreditLabel.Size = UDim2.new(1, 0, 0.08, 0)
CreditLabel.Font = Enum.Font.Gotham
CreditLabel.Text = "👑 Founder Scripts | t.me/FounderScripts 👑"
CreditLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
CreditLabel.TextScaled = true

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.Size = UDim2.new(0, 140, 0, 60)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "🌊 ОТКРЫТЬ МЕНЮ"
ToggleBtn.TextColor3 = Color3.fromRGB(15, 15, 25)
ToggleBtn.TextScaled = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

-- Feature Buttons
local buttons = {
    {name = "🛡️ Survival Mode", func = function() features.survivalMode = not features.survivalMode; survivalMode() end},
    {name = "🧱 VIP Walls Remove", func = function() features.vipWalls = not features.vipWalls; removeVIPWalls() end},
    {name = "🧠 Auto Brainrot", func = function() features.autoBrainrot = not features.autoBrainrot; autoBrainrot() end},
    {name = "🏃‍♂️ Auto Twin End", func = function() features.autoTwin = not features.autoTwin; autoTwin() end},
    {name = "💰 Auto Coins", func = function() features.autoCoins = not features.autoCoins; autoCoins() end},
    {name = "⚡ Auto Speed", func = function() features.autoSpeed = not features.autoSpeed; autoSpeed() end}
}

for i, btnData in pairs(buttons) do
    local Button = Instance.new("TextButton")
    Button.Name = btnData.name
    Button.Parent = ScrollFrame
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.Font = Enum.Font.GothamBold
    Button.Text = btnData.name .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.LayoutOrder = i
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(0, 255, 255)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        btnData.func()
        Button.Text = btnData.name .. (features[btnData.name:lower():gsub(" ", ""):gsub("%W", ""):lower()] and ": ON" or ": OFF")
        Button.BackgroundColor3 = features[btnData.name:lower():gsub(" ", ""):gsub("%W", ""):lower()] and 
            Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 60)
    end)
end

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
end)

-- Toggle GUI
local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    ToggleBtn.Text = guiVisible and "📴 ЗАКРЫТЬ" or "🌊 ОТКРЫТЬ МЕНЮ"
end

ToggleBtn.MouseButton1Click:Connect(toggleGUI)

-- Hotkey
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    end
end)

-- Auto respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootpart = char:WaitForChild("HumanoidRootPart")
    if features.survivalMode then
        survivalMode()
    end
end)

-- Notification
game:GetService("CoreGui"):SetCore("SendNotification", {
    Title = "🌊 Founder Scripts";
    Text = "Tsunami Ultimate загружен! Нажми кнопку или INSERT";
    Duration = 5;
})

print("✅ Tsunami Ultimate от Founder Scripts загружен!")
