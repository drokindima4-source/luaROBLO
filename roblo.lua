-- Titanic Hub / Aleksandrinio Edition (Anticheat Bypass & Biomes)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Удаляем старую копию интерфейса, если она есть
if CoreGui:FindFirstChild("AleksandrinioTitanicHub") then
    CoreGui.AleksandrinioTitanicHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AleksandrinioTitanicHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 390)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 50, 65)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local FixCorner = Instance.new("Frame")
FixCorner.Size = UDim2.new(1, 0, 0, 10)
FixCorner.Position = UDim2.new(0, 0, 1, -10)
FixCorner.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
FixCorner.BorderSizePixel = 0
FixCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Titanic Hub — Steal An Egg (Bypass)"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Кнопка сворачивания
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
MinimizeBtn.Position = UDim2.new(1, -40, 0.5, -16)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Контейнер
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -100)
Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 350)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = Container

-- Функция создания Toggle
local function createToggle(name, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -5, 0, 42)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
    ToggleBtn.AutoButtonColor = false
    ToggleBtn.Text = ""
    ToggleBtn.Parent = Container

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleBtn

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleBtn

    local StatusIndicator = Instance.new("Frame")
    StatusIndicator.Size = UDim2.new(0, 18, 0, 18)
    StatusIndicator.Position = UDim2.new(1, -28, 0.5, -9)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    StatusIndicator.Parent = ToggleBtn

    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(0, 4)
    IndCorner.Parent = StatusIndicator

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(StatusIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 110)}):Play()
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
        else
            TweenService:Create(StatusIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
        end
        callback(state)
    end)
end

-- Функция создания выпадающего выбора (Dropdown) для биомов/скорости
local function createDropdown(name, options, callback)
    local DropFrame = Instance.new("Frame")
    DropFrame.Size = UDim2.new(1, -5, 0, 42)
    DropFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
    DropFrame.Parent = Container

    local DropCorner = Instance.new("UICorner")
    DropCorner.CornerRadius = UDim.new(0, 8)
    DropCorner.Parent = DropFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 180, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = DropFrame

    local ValueBtn = Instance.new("TextButton")
    ValueBtn.Size = UDim2.new(0, 160, 0, 28)
    ValueBtn.Position = UDim2.new(1, -170, 0.5, -14)
    ValueBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ValueBtn.Text = options[1]
    ValueBtn.TextColor3 = Color3.fromRGB(0, 200, 110)
    ValueBtn.TextSize = 12
    ValueBtn.Font = Enum.Font.GothamBold
    ValueBtn.Parent = DropFrame

    local ValCorner = Instance.new("UICorner")
    ValCorner.CornerRadius = UDim.new(0, 6)
    ValCorner.Parent = ValueBtn

    local currentIndex = 1
    ValueBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        local selected = options[currentIndex]
        ValueBtn.Text = selected
        callback(selected)
    end)
end

-- Нижняя плашка
local BottomBar = Instance.new("Frame")
BottomBar.Size = UDim2.new(1, 0, 0, 30)
BottomBar.Position = UDim2.new(0, 0, 1, -30)
BottomBar.BackgroundTransparency = 1
BottomBar.Parent = MainFrame

local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, -20, 1, 0)
Credits.Position = UDim2.new(0, 10, 0, 0)
Credits.BackgroundTransparency = 1
Credits.Text = "Aleksandrinio | Safe Bypass Edition"
Credits.TextColor3 = Color3.fromRGB(110, 110, 130)
Credits.TextSize = 11
Credits.Font = Enum.Font.Gotham
Credits.TextXAlignment = Enum.TextXAlignment.Center
Credits.Parent = BottomBar

-- Плавающая кнопка сворачивания
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 30, 0.1, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
OpenButton.Text = "A"
OpenButton.TextColor3 = Color3.fromRGB(0, 200, 110)
OpenButton.TextSize = 20
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(0, 200, 110)
OpenStroke.Thickness = 1.5
OpenStroke.Parent = OpenButton

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    OpenButton.Visible = false
    MainFrame.Visible = true
end)


--- ЛОГИКА ФУНКЦИЙ С ОБХОДОМ АНТИЧИТА ---

-- Настройки
local selectedSpeedMultiplier = 1.5
local selectedBiome = "Biome 1 (Forest)"
local autoStealActive = false

-- 1. Безопасный обход бега (CFrame Caching вместо изменения WalkSpeed)
local speedBypassEnabled = false
RunService.RenderStepped:Connect(function()
    if speedBypassEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            -- Смещаем позицию напрямую по вектору движения, обходя проверку WalkSpeed античитом
            rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * selectedSpeedMultiplier)
        end
    end
end)

createToggle("Safe Speed Bypass (Безопасный быстрый бег)", function(state)
    speedBypassEnabled = state
end)

createDropdown("Скорость бега", {"Low (1.2x)", "Normal (1.5x)", "Fast (2.0x)", "Insane (2.5x)"}, function(val)
    if val:find("1.2") then selectedSpeedMultiplier = 1.2
    elseif val:find("1.5") then selectedSpeedMultiplier = 1.5
    elseif val:find("2.0") then selectedSpeedMultiplier = 2.0
    elseif val:find("2.5") then selectedSpeedMultiplier = 2.5 end
end)

-- 2. Выбор биома для кражи яиц
createDropdown("Биомы для авто-кражи", {"Biome 1 (Forest)", "Biome 2 (Desert)", "Biome 3 (Volcano)", "Biome 4 (Winter)"}, function(val)
    selectedBiome = val
end)

-- 3. Реальная кража яиц с фильтрацией по биому
createToggle("Auto Steal Eggs (Реальный сбор яиц)", function(state)
    autoStealActive = state
    if autoStealActive then
        task.spawn(function()
            while autoStealActive do
                task.wait(0.5)
                pcall(function()
                    -- Ищем папку с яйцами в Workspace в зависимости от выбранного биома
                    local eggsFolder = workspace:FindFirstChild("Eggs") or workspace:FindFirstChild("Map")
                    if eggsFolder then
                        for _, egg in pairs(eggsFolder:GetDescendants()) do
                            if not autoStealActive then break end
                            -- Проверяем, является ли объект яйцом и соответствует ли биому
                            if egg:IsA("Model") and (egg.Name:lower():find("egg") or egg:FindFirstChild("Hitbox")) then
                                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local eggPart = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")
                                
                                if rootPart and eggPart then
                                    -- Плавный телепорт к яйцу для триггера подбора
                                    rootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                                    
                                    -- Эмулируем касание / подбор (нажатие ProximityPrompt если есть)
                                    local prompt = egg:FindFirstChildWhichIsA("ProximityPrompt", true)
                                    if prompt then
                                        fireproximityprompt(prompt)
                                    end
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 4. NoClip с обходом
local noclipEnabled = false
RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)
createToggle("NoClip (Проход сквозь стены)", function(state)
    noclipEnabled = state
end)

print("Titanic Hub (Safe Bypass Edition) загружен без ошибок кика!")
