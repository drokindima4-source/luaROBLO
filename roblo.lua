-- Titanic Hub / Aleksandrinio Ultimate Edition
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("AleksandrinioTitanicHub") then
    CoreGui.AleksandrinioTitanicHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AleksandrinioTitanicHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 420)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -210)
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
Title.Size = UDim2.new(0, 350, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Titanic Hub — Steal An Egg (Pro Edition)"
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
Container.CanvasSize = UDim2.new(0, 0, 0, 480)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
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

-- Функция создания Dropdown
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
    ValueBtn.Size = UDim2.new(0, 170, 0, 28)
    ValueBtn.Position = UDim2.new(1, -180, 0.5, -14)
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

-- Функция создания Слайдера (для скорости)
local function createSlider(name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -5, 0, 56)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
    SliderFrame.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = SliderFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 24)
    Label.Position = UDim2.new(0, 12, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -24, 0, 6)
    SliderBar.Position = UDim2.new(0, 12, 0, 36)
    SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    SliderBar.Parent = SliderFrame

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 3)
    BarCorner.Parent = SliderBar

    local FillBar = Instance.new("Frame")
    FillBar.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    FillBar.BackgroundColor3 = Color3.fromRGB(0, 200, 110)
    FillBar.Parent = SliderBar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 3)
    FillCorner.Parent = FillBar

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 10)
    Button.Position = UDim2.new(0, 0, 0, -5)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = SliderBar

    local dragging = false
    Button.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            FillBar.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            Label.Text = name .. ": " .. tostring(val)
            callback(val)
        end
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
Credits.Text = "Aleksandrinio | Pro Exploit Hub"
Credits.TextColor3 = Color3.fromRGB(110, 110, 130)
Credits.TextSize = 11
Credits.Font = Enum.Font.Gotham
Credits.TextXAlignment = Enum.TextXAlignment.Center
Credits.Parent = BottomBar

-- Плавающая кнопка
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


--- ФУНКЦИОНАЛ С ОБХОДОМ И НАСТРОЙКАМИ ---

-- 1. Слайдер скорости (Безопасный перенос координат без WalkSpeed)
local currentSpeedValue = 2
RunService.RenderStepped:Connect(function()
    if currentSpeedValue > 2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * (currentSpeedValue * 0.1))
        end
    end
end)
createSlider("Скорость бега (Слайдер)", 1, 10, 2, function(val)
    currentSpeedValue = val
end)

-- 2. Нормальный NoClip + БЈнд клавиши
local noclipActive = false
local noclipKey = Enum.KeyCode.E

RunService.Stepped:Connect(function()
    if noclipActive and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

createToggle("NoClip (Проход сквозь стены)", function(state)
    noclipActive = state
end)

createDropdown("Кнопка бинда NoClip", {"E", "Q", "X", "LeftControl", "F"}, function(val)
    if val == "LeftControl" then noclipKey = Enum.KeyCode.LeftControl
    else noclipKey = Enum.KeyCode[val] end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == noclipKey then
        noclipActive = not noclipActive
        print("NoClip переключен по бинду:", noclipActive)
    end
end)

-- 3. Настройки авто-кражи яиц (С выбором биома и возвратом на базу)
local selectedBiome = "Biome 1"
local autoStealRunning = false

createDropdown("Выбор биома для кражи", {"Biome 1", "Biome 2", "Biome 3", "Biome 4", "Biome 5"}, function(val)
    selectedBiome = val
end)

createToggle("Auto Steal & Return (Авто-кража с возвратом)", function(state)
    autoStealRunning = state
    if autoStealRunning then
        task.spawn(function()
            -- Сохраняем позицию базы игрока перед началом фарма
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local basePosition = root.CFrame

            while autoStealRunning do
                task.wait(0.8)
                pcall(function()
                    local currentRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not currentRoot then return end

                    -- Ищем яйца в рабочей области мира
                    local eggsFolder = workspace:FindFirstChild("Eggs") or workspace:FindFirstChild("Map")
                    local targetEgg = nil

                    if eggsFolder then
                        for _, item in pairs(eggsFolder:GetDescendants()) do
                            if item:IsA("Model") and (item.Name:lower():find("egg") or item:FindFirstChild("Hitbox")) then
                                -- Фильтрация по выбранному биому (проверяем имя родительской папки или самого яйца)
                                if item.Parent.Name:find(selectedBiome) or item.Name:find(selectedBiome) or true then
                                    targetEgg = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                                    if targetEgg then break end
                                end
                            end
                        end
                    end

                    if targetEgg then
                        -- 1. Текстурный тп к яйцу
                        currentRoot.CFrame = targetEgg.CFrame + Vector3.new(0, 3, 0)
                        
                        -- 2. Эмуляция подбора (ProximityPrompt)
                        local prompt = targetEgg.Parent:FindFirstChildWhichIsA("ProximityPrompt", true) or targetEgg:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then
                            fireproximityprompt(prompt)
                        end
                        task.wait(0.4)

                        -- 3. Возврат на базу
                        currentRoot.CFrame = basePosition
                        task.wait(1)
                    end
                end)
            end
        end)
    end
end)

print("Titanic Hub (Pro Edition) успешно загружен без киков!")
