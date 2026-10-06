--[[
    ROCKET // Grow a Garden — AUTO FARM v2
    Rocket Way // 20.05.2026
    Добавлено: авто-покупка семян в магазине.
--]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local Tween = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")

-- ===== НАСТРОЙКИ =====
local S = {
    autobuy = false,       -- авто-покупка семян
    autocollect = false,
    autoplant = false,
    autowater = false,
    autosell = false,
    autopickup = false,
    buyDelay = 1,
    collectDelay = 0.3,
    plantDelay = 0.5,
    sellDelay = 2,
    buyAmount = 1,         -- сколько жать "Buy" за раз
}

-- ===== GUI =====
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "ROCKET_Garden"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 220, 0, 420)
main.Position = UDim2.new(0, 8, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(15, 25, 15)
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local grad = Instance.new("Frame", main)
grad.Size = UDim2.new(1, 0, 1, 0)
grad.BackgroundColor3 = Color3.fromRGB(10, 20, 10)
grad.BackgroundTransparency = 0.5
grad.BorderSizePixel = 0
grad.ZIndex = 2
local ug = Instance.new("UIGradient", grad)
ug.Rotation = 90
ug.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 150, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 200, 80)),
})

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(100, 255, 120)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 26)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.BackgroundTransparency = 0.5
title.Text = "🌱 ROCKET // GARDEN v2"
title.TextColor3 = Color3.fromRGB(180, 255, 180)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.ZIndex = 5

local minB = Instance.new("TextButton", title)
minB.Size = UDim2.new(0, 26, 1, 0)
minB.Position = UDim2.new(1, -26, 0, 0)
minB.BackgroundTransparency = 1
minB.Text = "—"
minB.TextColor3 = Color3.new(1, 1, 1)
minB.Font = Enum.Font.GothamBold
minB.TextSize = 14
minB.ZIndex = 6

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -8, 1, -32)
scroll.Position = UDim2.new(0, 4, 0, 28)
scroll.BackgroundTransparency = 0.7
scroll.BackgroundColor3 = Color3.fromRGB(5, 15, 5)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
scroll.ScrollBarThickness = 2
scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 255, 120)
scroll.ZIndex = 4

local lay = Instance.new("UIListLayout", scroll)
lay.Padding = UDim.new(0, 4)

local function btn(text, cb)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, -6, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(25, 50, 25)
    b.BackgroundTransparency = 0.3
    b.TextColor3 = Color3.fromRGB(200, 255, 200)
    b.Font = Enum.Font.Gotham
    b.TextSize = 11
    b.Text = text
    b.ZIndex = 5
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(80, 180, 100)
    s.Transparency = 0.5
    b.MouseButton1Click:Connect(cb)
    return b
end

local function hdr(t)
    local l = Instance.new("TextLabel", scroll)
    l.Size = UDim2.new(1, -6, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = "✦ " .. t .. " ✦"
    l.TextColor3 = Color3.fromRGB(120, 255, 140)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.ZIndex = 5
    return l
end

-- ===== ПОДБОР ПРЕДМЕТОВ =====
local function pickupNearby()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Model") then
            local n = v.Name:lower()
            if n:find("fruit") or n:find("seed") or n:find("harvest") or n:find("drop") or n:find("coin") then
                local pos = v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart.Position or (v.Position or nil)
                if pos and (pos - Root.Position).Magnitude < 30 then
                    pcall(function()
                        local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
                        if part then
                            firetouchinterest(Root, part, 0)
                            task.wait(0.01)
                            firetouchinterest(Root, part, 1)
                        end
                    end)
                end
            end
        end
    end
end

-- ===== НАЖАТИЕ КНОПОК UI =====
local function clickButtonByName(partOfName)
    local found = false
    for _, d in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if d:IsA("TextButton") and d.Text then
            if d.Text:lower():find(partOfName:lower()) then
                pcall(function() d.MouseButton1Click:Fire() end)
                found = true
            end
        end
    end
    for _, d in pairs(LP:GetDescendants()) do
        if d:IsA("TextButton") and d.Text then
            if d.Text:lower():find(partOfName:lower()) then
                pcall(function() d.MouseButton1Click:Fire() end)
                found = true
            end
        end
    end
    return found
end

-- ===== ПОИСК КНОПОК ПОКУПКИ В МАГАЗИНЕ =====
-- Ищет все TextButton в UI, у которых текст похож на "Buy"/"Купить"/"Purchase"
local function clickBuyButtons()
    local count = 0
    local function tryClick(container)
        for _, d in pairs(container:GetDescendants()) do
            if d:IsA("TextButton") and d.Text then
                local t = d.Text:lower()
                if t:find("buy") or t:find("purchase") or t:find("купить") or t:find("seed") and t:find("buy") then
                    pcall(function() d.MouseButton1Click:Fire() end)
                    count = count + 1
                end
            end
        end
    end
    tryClick(game:GetService("CoreGui"))
    tryClick(LP)
    return count
end

-- ===== ЛОГИКА =====

-- АВТО-ПОКУПКА СЕМЯН
task.spawn(function()
    while task.wait(S.buyDelay) do
        if S.autobuy then
            for i = 1, S.buyAmount do
                pcall(clickBuyButtons)
            end
            -- на всякий случай пробуем через прямые имена
            clickButtonByName("buy seed")
            clickButtonByName("purchase")
            clickButtonByName("купить семена")
        end
    end
end)

-- АВТО-СБОР
task.spawn(function()
    while task.wait(S.collectDelay) do
        if S.autocollect then
            clickButtonByName("collect")
            clickButtonByName("harvest")
            clickButtonByName("собрать")
        end
    end
end)

-- АВТО-ПОСАДКА
task.spawn(function()
    while task.wait(S.plantDelay) do
        if S.autoplant then
            clickButtonByName("plant")
            clickButtonByName("посадить")
        end
    end
end)

-- АВТО-ПОЛИВ
task.spawn(function()
    while task.wait(1) do
        if S.autowater then
            clickButtonByName("water")
            clickButtonByName("полить")
        end
    end
end)

-- АВТО-ПРОДАЖА
task.spawn(function()
    while task.wait(S.sellDelay) do
        if S.autosell then
            clickButtonByName("sell")
            clickButtonByName("продать")
        end
    end
end)

-- АВТО-ПОДБОР
task.spawn(function()
    while task.wait(0.2) do
        if S.autopickup then
            pcall(pickupNearby)
        end
    end
end)

-- ===== МЕНЮ =====
hdr("ЭКОНОМИКА")
btn("Авто-покупка семян: ВЫКЛ", function(b)
    S.autobuy = not S.autobuy
    b.Text = "Авто-покупка семян: " .. (S.autobuy and "ВКЛ" or "ВЫКЛ")
end)
btn("Покупать x1", function(b)
    S.buyAmount = 1
    b.Text = "Покупать x1 ✅"
end)
btn("Покупать x3", function(b)
    S.buyAmount = 3
    b.Text = "Покупать x3 ✅"
end)
btn("Покупать x5", function(b)
    S.buyAmount = 5
    b.Text = "Покупать x5 ✅"
end)

hdr("АВТО-ФАРМ")
btn("Авто-сбор: ВЫКЛ", function(b)
    S.autocollect = not S.autocollect
    b.Text = "Авто-сбор: " .. (S.autocollect and "ВКЛ" or "ВЫКЛ")
end)
btn("Авто-посадка: ВЫКЛ", function(b)
    S.autoplant = not S.autoplant
    b.Text = "Авто-посадка: " .. (S.autoplant and "ВКЛ" or "ВЫКЛ")
end)
btn("Авто-полив: ВЫКЛ", function(b)
    S.autowater = not S.autowater
    b.Text = "Авто-полив: " .. (S.autowater and "ВКЛ" or "ВЫКЛ")
end)
btn("Авто-продажа: ВЫКЛ", function(b)
    S.autosell = not S.autosell
    b.Text = "Авто-продажа: " .. (S.autosell and "ВКЛ" or "ВЫКЛ")
end)
btn("Авто-подбор: ВЫКЛ", function(b)
    S.autopickup = not S.autopickup
    b.Text = "Авто-подбор: " .. (S.autopickup and "ВКЛ" or "ВЫКЛ")
end)

hdr("ПОЛНЫЙ ЦИКЛ")
btn("🚀 ВСЁ ВКЛ (полный фарм)", function(b)
    S.autobuy = true
    S.autocollect = true
    S.autoplant = true
    S.autowater = true
    S.autosell = true
    S.autopickup = true
    b.Text = "🚀 ВСЁ ВКЛ ✅"
end)
btn("⛔ ВСЁ ВЫКЛ", function(b)
    S.autobuy = false
    S.autocollect = false
    S.autoplant = false
    S.autowater = false
    S.autosell = false
    S.autopickup = false
    b.Text = "⛔ ВСЁ ВЫКЛ ✅"
end)

hdr("ТЕСТ")
btn("Показать кнопки UI", function()
    print("=== ROCKET: кнопки ===")
    for _, d in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if d:IsA("TextButton") and d.Text ~= "" then print("CoreGui:", d.Text) end
    end
    for _, d in pairs(LP:GetDescendants()) do
        if d:IsA("TextButton") and d.Text ~= "" then print("PlayerGui:", d.Text) end
    end
end)
btn("Показать Remote", function()
    print("=== ROCKET: RemoteEvents ===")
    for _, d in pairs(RS:GetDescendants()) do
        if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
            print(d.ClassName, "→", d:GetFullName())
        end
    end
end)

-- ===== СВОРАЧИВАНИЕ / ПЕРЕТАСК =====
local mini = false
minB.MouseButton1Click:Connect(function()
    mini = not mini
    scroll.Visible = not mini
    grad.Visible = not mini
    main.Size = mini and UDim2.new(0, 220, 0, 26) or UDim2.new(0, 220, 0, 420)
    minB.Text = mini and "+" or "—"
end)

local drag, dS, dP
title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true; dS = i.Position; dP = main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - dS
        main.Position = UDim2.new(dP.X.Scale, dP.X.Offset + d.X, dP.Y.Scale, dP.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)

LP.CharacterAdded:Connect(function(c)
    Char = c
    Hum = c:WaitForChild("Humanoid")
    Root = c:WaitForChild("HumanoidRootPart")
end)

print("ROCKET // Grow a Garden v2 загружен. Rocket Way 20.05.2026")
