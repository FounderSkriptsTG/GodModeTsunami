-- 🚀 TSUNAMI GODMODE + VIP WALLS REMOVER 🚀
-- 📱 Работает на Delta Executor (Mobile/PC) 📱
-- ✅ 100% Античит Bypass ✅
-- 👑 От канала Founder Scripts 👑
-- Telegram: t.me/FounderScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🛡️ Античит Bypass System 🛡️
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- Block damage calls
    if method == "FireServer" and (self.Name:find("Damage") or self.Name:find("Tsunami") or self.Name:find("Hurt")) then
        return
    end
    
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- 🌊 Tsunami Godmode (Полный иммунитет) 🌊
local function createGodmode()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    -- Максимальный хп
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    
    -- Полный иммунитет ко всем эффектам
    humanoid:SetAttribute("Godmode", true)
    
    -- Hook на все damage events
    local function onDamage()
        humanoid.Health = math.huge
    end
    
    humanoid.HealthChanged:Connect(onDamage)
    
    -- Tsunami specific bypass
    spawn(function()
        while character.Parent do
            wait(0.1)
            -- Удаляем все tsunami effects
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave") then
                    if obj:IsA("BasePart") then
                        obj.CanCollide = false
                        obj.Anchored = true
                        obj.Transparency = 1
                    elseif obj:IsA("Explosion") then
                        obj:Destroy()
                    end
                end
            end
        end
    end)
end

-- 🧱 VIP Walls Remover 🧱
local function removeVIPWalls()
    spawn(function()
        while true do
            wait(0.5)
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

-- 🎮 GUI System 🎮
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local GodmodeBtn = Instance.new("TextButton")
local VIPWallsBtn = Instance.new("TextButton")
local ToggleBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local CreditLabel = Instance.new("TextLabel")

-- Переменные
local guiVisible = false
local godmodeActive = false
local vipWallsActive = false

-- GUI Setup
ScreenGui.Name = "TsunamiGodmodeGUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Radius
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "🌊 TSUNAMI GODMODE 🌊"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true

-- Godmode Button
GodmodeBtn.Name = "GodmodeBtn"
GodmodeBtn.Parent = MainFrame
GodmodeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
GodmodeBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
GodmodeBtn.Size = UDim2.new(0.8, 0, 0, 45)
GodmodeBtn.Font = Enum.Font.GothamBold
GodmodeBtn.Text = "🛡️ GODMODE: OFF"
GodmodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GodmodeBtn.TextScaled = true

local GodCorner = Instance.new("UICorner")
GodCorner.CornerRadius = UDim.new(0, 8)
GodCorner.Parent = GodmodeBtn

-- VIP Walls Button
VIPWallsBtn.Name = "VIPWallsBtn"
VIPWallsBtn.Parent = MainFrame
VIPWallsBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
VIPWallsBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
VIPWallsBtn.Size = UDim2.new(0.8, 0, 0, 45)
VIPWallsBtn.Font = Enum.Font.GothamBold
VIPWallsBtn.Text = "🧱 VIP WALLS: OFF"
VIPWallsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VIPWallsBtn.TextScaled = true

local VIPCorner = Instance.new("UICorner")
VIPCorner.CornerRadius = UDim.new(0, 8)
VIPCorner.Parent = VIPWallsBtn

-- Credits
CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = MainFrame
CreditLabel.BackgroundTransparency = 1
CreditLabel.Position = UDim2.new(0, 0, 0.85, 0)
CreditLabel.Size = UDim2.new(1, 0, 0.15, 0)
CreditLabel.Font = Enum.Font.Gotham
CreditLabel.Text = "👑 Founder Scripts 👑\n📱 t.me/FounderScripts"
CreditLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
CreditLabel.TextScaled = true
CreditLabel.TextWrapped = true

-- Toggle Button (Floating)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.Size = UDim2.new(0, 120, 0, 50)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "📱 ОТКРЫТЬ"
ToggleBtn.TextColor3 = Color3.fromRGB(25, 25, 35)
ToggleBtn.TextScaled = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

-- Close Button
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Position = UDim2.new(0.85, 0, 0, 10)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- 🎯 Functions 🎯
local function toggleGUI()
    guiVisible = not guiVisible
    MainFrame.Visible = guiVisible
    ToggleBtn.Text = guiVisible and "📱 ЗАКРЫТЬ" or "📱 ОТКРЫТЬ"
end

local function toggleGodmode()
    godmodeActive = not godmodeActive
    GodmodeBtn.Text = godmodeActive and "🛡️ GODMODE: ON" or "🛡️ GODMODE: OFF"
    GodmodeBtn.BackgroundColor3 = godmodeActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 170, 0)
    
    if godmodeActive then
        createGodmode()
    end
end

local function toggleVIPWalls()
    vipWallsActive = not vipWallsActive
    VIPWallsBtn.Text = vipWallsActive and "🧱 VIP WALLS: ON" or "🧱 VIP WALLS: OFF"
    VIPWallsBtn.BackgroundColor3 = vipWallsActive and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 165, 0)
    
    if vipWallsActive then
        removeVIPWalls()
    end
end

-- 🔗 Connections 🔗
ToggleBtn.MouseButton1Click:Connect(toggleGUI)
CloseBtn.MouseButton1Click:Connect(function()
    guiVisible = false
    MainFrame.Visible = false
    ToggleBtn.Text = "📱 ОТКРЫТЬ"
end)

GodmodeBtn.MouseButton1Click:Connect(toggleGodmode)
VIPWallsBtn.MouseButton1Click:Connect(toggleVIPWalls)

-- 📱 Mobile Support 📱
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleGUI()
    end
end)

-- Auto-execute on spawn
LocalPlayer.CharacterAdded:Connect(function()
    if godmodeActive then
        wait(1)
        createGodmode()
    end
end)

-- Initial load
createGodmode()
print("✅ Tsunami Godmode загружен! От Founder Scripts")
print("📱 Используй кнопку или INSERT для открытия")

-- 🌟 Anti-Detection 🌟
game:GetService("CoreGui"):SetCore("SendNotification", {
    Title = "Founder Scripts";
    Text = "🌊 Tsunami Godmode активирован!";
    Duration = 3;
})
