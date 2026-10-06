-- ROCKET // Blade Ball Lite (Arceus X safe)
-- Rocket Way 20.05.2026
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Tween = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")

local S = {
    auto = false, spam = false, adapt = true,
    interval = 0.03, radius = 14,
    particles = true, sound = true,
}

local FONS = {
    "rbxassetid://13187042521",
    "rbxassetid://12687514336",
    "rbxassetid://10080412432",
}
local fonIdx = 1

local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name = "ROCKET_BB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 540)
main.Position = UDim2.new(0, 10, 0.5, -270)
main.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local bg = Instance.new("ImageLabel", main)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundTransparency = 1
bg.Image = FONS[1]
bg.ScaleType = Enum.ScaleType.Crop
bg.ImageTransparency = 0.3
bg.ZIndex = 1

local grad = Instance.new("Frame", main)
grad.Size = UDim2.new(1, 0, 1, 0)
grad.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
grad.BackgroundTransparency = 0.4
grad.BorderSizePixel = 0
grad.ZIndex = 2
local ug = Instance.new("UIGradient", grad)
ug.Rotation = 90
ug.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 20, 160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 120)),
})

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(180, 60, 255)
stroke.Thickness = 2
stroke.Transparency = 0.3

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 34)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.BackgroundTransparency = 0.5
title.Text = "🌸 ROCKET // BLADE BALL 🌸"
title.TextColor3 = Color3.fromRGB(255, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.ZIndex = 5

local minB = Instance.new("TextButton", title)
minB.Size = UDim2.new(0, 30, 1, 0)
minB.Position = UDim2.new(1, -30, 0, 0)
minB.BackgroundTransparency = 1
minB.Text = "—"
minB.TextColor3 = Color3.new(1, 1, 1)
minB.Font = Enum.Font.GothamBold
minB.TextSize = 18
minB.ZIndex = 6

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -12, 1, -46)
scroll.Position = UDim2.new(0, 6, 0, 40)
scroll.BackgroundTransparency = 0.6
scroll.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 1200)
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(200, 100, 255)
scroll.ZIndex = 4

local lay = Instance.new("UIListLayout", scroll)
lay.Padding = UDim.new(0, 6)

local function btn(text, cb)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, -6, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
    b.BackgroundTransparency = 0.3
    b.TextColor3 = Color3.fromRGB(255, 230, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.Text = text
    b.ZIndex = 5
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(150, 80, 220)
    s.Transparency = 0.5
    b.MouseButton1Click:Connect(cb)
    return b
end

local function hdr(t)
    local l = Instance.new("TextLabel", scroll)
    l.Size = UDim2.new(1, -6, 0, 24)
    l.BackgroundTransparency = 1
    l.Text = "✦ " .. t .. " ✦"
    l.TextColor3 = Color3.fromRGB(255, 150, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.ZIndex = 5
    return l
end

local info = Instance.new("Frame", scroll)
info.Size = UDim2.new(1, -6, 0, 60)
info.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
info.BackgroundTransparency = 0.4
info.BorderSizePixel = 0
info.ZIndex = 5
Instance.new("UICorner", info).CornerRadius = UDim.new(0, 8)

local spdL = Instance.new("TextLabel", info)
spdL.Size = UDim2.new(1, -10, 0, 18)
spdL.Position = UDim2.new(0, 5, 0, 4)
spdL.BackgroundTransparency = 1
spdL.Text = "⚡ Скорость: 0 стад/с"
spdL.TextColor3 = Color3.fromRGB(255, 180, 255)
spdL.Font = Enum.Font.GothamBold
spdL.TextSize = 12
spdL.TextXAlignment = Enum.TextXAlignment.Left
spdL.ZIndex = 6

local autL = Instance.new("TextLabel", info)
autL.Size = UDim2.new(1, -10, 0, 18)
autL.Position = UDim2.new(0, 5, 0, 26)
autL.BackgroundTransparency = 1
autL.Text = "Авто: 0.03 / 14"
autL.TextColor3 = Color3.fromRGB(120, 255, 200)
autL.Font = Enum.Font.Gotham
autL.TextSize = 12
autL.TextXAlignment = Enum.TextXAlignment.Left
autL.ZIndex = 6

local fonL = Instance.new("TextLabel", info)
fonL.Size = UDim2.new(1, -10, 0, 14)
fonL.Position = UDim2.new(0, 5, 0, 44)
fonL.BackgroundTransparency = 1
fonL.Text = "Фон: Тянка 1"
fonL.TextColor3 = Color3.fromRGB(255, 200, 255)
fonL.Font = Enum.Font.Gotham
fonL.TextSize = 11
fonL.TextXAlignment = Enum.TextXAlignment.Left
fonL.ZIndex = 6

-- ===== ЧАСТИЦЫ =====
local parts = {}
task.spawn(function()
    while task.wait(0.4) do
        if S.particles and #parts < 20 then
            local p = Instance.new("TextLabel", gui)
            p.Size = UDim2.new(0, 14, 0, 14)
            p.BackgroundTransparency = 1
            p.Text = "🌸"
            p.TextSize = 14
            p.TextColor3 = Color3.fromRGB(255, 180, 220)
            p.ZIndex = 1
            p.Position = UDim2.new(math.random(), 0, -0.05, 0)
            table.insert(parts, {o = p, vy = 0.004 + math.random() * 0.004, vx = (math.random() - 0.5) * 0.02})
        end
        for i = #parts, 1, -1 do
            local q = parts[i]
            if not q.o.Parent then
                table.remove(parts, i)
            else
                local pos = q.o.Position
                q.o.Position = UDim2.new(pos.X.Scale + q.vx * 0.05, 0, pos.Y.Scale + q.vy, 0)
                q.o.Rotation = q.o.Rotation + 2
                if pos.Y.Scale > 1.1 then
                    q.o:Destroy()
                    table.remove(parts, i)
                end
            end
        end
    end
end)

-- ===== ЗВУК =====
local function playSnd()
    if not S.sound then return end
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://9120386436"
    s.Volume = 0.5
    s.Parent = gui
    s:Play()
    task.delay(3, function() s:Destroy() end)
end

-- ===== МЯЧ =====
local function findBall()
    local best, bd = nil, 1e9
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower()
            if n:find("ball") or n:find("blade") or n:find("sphere") then
                local d = (v.Position - Root.Position).Magnitude
                if d < bd then bd = d; best = v end
            end
        end
    end
    return best, bd
end

local ball, lastPos, lastT = nil, nil, tick()
local speed = 0

RunService.RenderStepped:Connect(function()
    local b = findBall()
    if b then
        local now = tick()
        if ball == b and lastPos then
            local dt = now - lastT
            if dt > 0 then speed = (b.Position - lastPos).Magnitude / dt end
        end
        ball, lastPos, lastT = b, b.Position, now
    else
        speed = 0
    end
    spdL.Text = string.format("⚡ Скорость: %.0f стад/с", speed)

    if S.adapt then
        local iv, r
        if speed < 30 then iv, r = 0.05, 10
        elseif speed < 70 then iv, r = 0.03, 14
        elseif speed < 120 then iv, r = 0.02, 18
        else iv, r = 0.01, 22 end
        S.interval, S.radius = iv, r
        autL.Text = string.format("Авто: %.3f / %d", iv, r)
    else
        autL.Text = string.format("Ручной: %.3f / %d", S.interval, S.radius)
    end
end)

-- ===== ПАРИРОВАНИЕ =====
local function block()
    pcall(function()
        if keypress then keypress(0x46) end
        if keyrelease then keyrelease(0x46) end
    end)
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.01)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end)
end

task.spawn(function()
    while task.wait(0.01) do
        if S.auto then
            local b, d = findBall()
            if b and d <= S.radius then block() end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(S.interval)
        if S.spam then block() end
    end
end)

-- ===== МЕНЮ =====
hdr("ПАРИРОВАНИЕ")
btn("Авто-парирование: ВЫКЛ", function(b)
    S.auto = not S.auto
    b.Text = "Авто-парирование: " .. (S.auto and "ВКЛ" or "ВЫКЛ")
end)
btn("Спам парированием: ВЫКЛ", function(b)
    S.spam = not S.spam
    b.Text = "Спам парированием: " .. (S.spam and "ВКЛ" or "ВЫКЛ")
end)
btn("Авто-адаптация: ВКЛ", function(b)
    S.adapt = not S.adapt
    b.Text = "Авто-адаптация: " .. (S.adapt and "ВКЛ" or "ВЫКЛ")
end)

hdr("НАСТРОЙКИ")
btn("Интервал -0.01", function()
    if not S.adapt then S.interval = math.max(0.01, S.interval - 0.01) end
end)
btn("Интервал +0.01", function()
    if not S.adapt then S.interval = math.min(0.2, S.interval + 0.01) end
end)
btn("Радиус -2", function()
    if not S.adapt then S.radius = math.max(5, S.radius - 2) end
end)
btn("Радиус +2", function()
    if not S.adapt then S.radius = math.min(30, S.radius + 2) end
end)

hdr("ВИЗУАЛ")
btn("Сменить фон (тянка)", function(b)
    fonIdx = fonIdx + 1
    if fonIdx > #FONS then fonIdx = 1 end
    bg.Image = FONS[fonIdx]
    bg.ImageTransparency = 1
    Tween:Create(bg, TweenInfo.new(0.5), {ImageTransparency = 0.3}):Play()
    fonL.Text = "Фон: Тянка " .. fonIdx
end)
btn("Частицы сакуры: ВКЛ", function(b)
    S.particles = not S.particles
    b.Text = "Частицы сакуры: " .. (S.particles and "ВКЛ" or "ВЫКЛ")
    if not S.particles then
        for _, q in ipairs(parts) do q.o:Destroy() end
        parts = {}
    end
end)
btn("Звук: ВКЛ", function(b)
    S.sound = not S.sound
    b.Text = "Звук: " .. (S.sound and "ВКЛ" or "ВЫКЛ")
    playSnd()
end)

hdr("КАСТОМ")
btn("Убрать голову", function()
    local h = Char:FindFirstChild("Head")
    if h then h.Transparency = 1 end
end)
btn("Заменить ноги (неон)", function()
    for _, n in ipairs({"Left Leg", "Right Leg", "LeftUpperLeg", "RightUpperLeg"}) do
        local l = Char:FindFirstChild(n)
        if l then l.Material = Enum.Material.Neon; l.BrickColor = BrickColor.new("Bright red") end
    end
end)
btn("Взрыв под ногами", function()
    local e = Instance.new("Explosion")
    e.Position = Root.Position
    e.BlastRadius = 5
    e.BlastPressure = 0
    e.Parent = workspace
end)

hdr("БОНУСЫ")
btn("Ускорение (60)", function() Hum.WalkSpeed = 60 end)
btn("Прыжок (120)", function() Hum.JumpPower = 120; Hum.UseJumpPower = true end)
btn("Сброс", function() Hum.WalkSpeed = 16; Hum.JumpPower = 50 end)

-- ===== СВОРАЧИВАНИЕ / ПЕРЕТАСК =====
local mini = false
minB.MouseButton1Click:Connect(function()
    mini = not mini
    scroll.Visible = not mini
    bg.Visible = not mini
    grad.Visible = not mini
    main.Size = mini and UDim2.new(0, 300, 0, 34) or UDim2.new(0, 300, 0, 540)
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

Tween:Create(main, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
Tween:Create(bg, TweenInfo.new(0.6), {ImageTransparency = 0.3}):Play()
playSnd()

LP.CharacterAdded:Connect(function(c)
    Char = c
    Hum = c:WaitForChild("Humanoid")
    Root = c:WaitForChild("HumanoidRootPart")
end)

print("ROCKET // Blade Ball Lite OK")