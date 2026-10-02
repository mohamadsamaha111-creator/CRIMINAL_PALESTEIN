-- Criminal Palestine GUI (Blue Theme)
-- UI / testing version

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- ========
-- GUI CREATION
-- ========

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CriminalPalestineGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 420)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Criminal Palestine"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Parent = MainFrame

-- ========
-- TABS
-- ========

local Tabs = {
    "Home",
    "Events",
    "Find Server",
    "Customization"
}

local TabFrames = {}
local TabButtons = {}

for i, tabName in ipairs(Tabs) do

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, 10 + (i - 1) * 125, 0, 50)
    btn.Text = tabName
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.BorderSizePixel = 0
    btn.Parent = MainFrame

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, -20, 1, -100)
    frame.Position = UDim2.new(0, 10, 0, 95)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 6
    frame.CanvasSize = UDim2.new(0, 0, 0, 500)
    frame.Visible = (i == 1)
    frame.Parent = MainFrame

    TabButtons[tabName] = btn
    TabFrames[tabName] = frame

    btn.MouseButton1Click:Connect(function()

        for _, f in pairs(TabFrames) do
            f.Visible = false
        end

        for _, b in pairs(TabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
        end

        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end)
end

-- ========
-- HELPERS
-- ========

local function addLabel(parent, text, y)
    local lbl = Instance.new("TextLabel")

    lbl.Size = UDim2.new(1, -20, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(200, 200, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent

    return lbl
end

local function addToggle(parent, text, y, default)
    local frame = Instance.new("Frame")

    frame.Size = UDim2.new(1, -20, 0, 25)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(200, 200, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 20, 0, 20)
    toggle.Position = UDim2.new(0.8, 0, 0, 2.5)
    toggle.BackgroundColor3 =
        default
        and Color3.fromRGB(0, 170, 0)
        or Color3.fromRGB(170, 0, 0)

    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.Parent = frame

    local state = default

    toggle.MouseButton1Click:Connect(function()
        state = not state

        toggle.BackgroundColor3 =
            state
            and Color3.fromRGB(0, 170, 0)
            or Color3.fromRGB(170, 0, 0)
    end)

    return toggle
end

local function addDropdown(parent, label, options, y, default)
    local frame = Instance.new("Frame")

    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 100, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(200, 200, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 150, 1, 0)
    dropdown.Position = UDim2.new(0, 110, 0, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
    dropdown.Text = default or options[1]
    dropdown.Font = Enum.Font.SourceSans
    dropdown.TextSize = 16
    dropdown.TextColor3 = Color3.fromRGB(200, 200, 255)
    dropdown.BorderSizePixel = 0
    dropdown.Parent = frame

    local open = false

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(0, 150, 0, math.min(#options * 25, 120))
    list.Position = UDim2.new(0, 110, 0, 30)
    list.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 4
    list.CanvasSize = UDim2.new(0, 0, 0, #options * 25)
    list.Visible = false
    list.ZIndex = 10
    list.Parent = frame

    for index, opt in ipairs(options) do

        local optBtn = Instance.new("TextButton")

        optBtn.Size = UDim2.new(1, 0, 0, 25)
        optBtn.Position = UDim2.new(0, 0, 0, (index - 1) * 25)
        optBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
        optBtn.Text = opt
        optBtn.Font = Enum.Font.SourceSans
        optBtn.TextSize = 14
        optBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
        optBtn.BorderSizePixel = 0
        optBtn.ZIndex = 11
        optBtn.Parent = list

        optBtn.MouseButton1Click:Connect(function()
            dropdown.Text = opt
            list.Visible = false
            open = false
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        open = not open
        list.Visible = open
    end)

    return dropdown
end

local function addButton(parent, text, y, callback)
    local btn = Instance.new("TextButton")

    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Parent = parent

    btn.MouseButton1Click:Connect(callback)

    return btn
end

-- ========
-- HOME TAB
-- ========

local home = TabFrames["Home"]
local yOffset = 10

addLabel(home, "AUTO FEATURES", yOffset)
yOffset = yOffset + 25

local autoStealToggle =
    addToggle(home, "Auto Steal", yOffset, false)
yOffset = yOffset + 30

local autoTradeToggle =
    addToggle(home, "Auto Trade", yOffset, false)
yOffset = yOffset + 30

local autoPlaceEggToggle =
    addToggle(home, "Auto Place Egg", yOffset, false)
yOffset = yOffset + 30

local autoBreakEggToggle =
    addToggle(home, "Auto Break Egg", yOffset, false)
yOffset = yOffset + 30

addLabel(home, "ANIMATIONS / EFFECTS", yOffset)
yOffset = yOffset + 25

local animDropdown =
    addDropdown(
        home,
        "Select Animation",
        {"Gold", "Diamond", "Rainbow", "Fire"},
        yOffset,
        "Gold"
    )

yOffset = yOffset + 35

addLabel(home, "ITEMS TO STEAL", yOffset)
yOffset = yOffset + 25

local itemsDropdown =
    addDropdown(
        home,
        "Select Item",
        {"Gold Coins", "Diamonds", "Eggs", "Rare Artifacts"},
        yOffset,
        "Gold Coins"
    )

yOffset = yOffset + 35

addButton(home, "Select All Items", yOffset, function()
    itemsDropdown.Text = "All Items"
end)

yOffset = yOffset + 40

addLabel(home, "AREAS / MAPS", yOffset)
yOffset = yOffset + 25

local areasDropdown =
    addDropdown(
        home,
        "Select Area",
        {"Bank", "Museum", "Vault", "Secret Lab"},
        yOffset,
        "Bank"
    )

yOffset = yOffset + 35

addButton(home, "Select All Areas", yOffset, function()
    areasDropdown.Text = "All Areas"
end)

yOffset = yOffset + 40

addLabel(home, "PLACES (SPECIFIC LOCATIONS)", yOffset)
yOffset = yOffset + 25

local placesDropdown =
    addDropdown(
        home,
        "Select Place",
        {"Safe", "Chest", "Locker", "Box"},
        yOffset,
        "Safe"
    )

yOffset = yOffset + 35

addButton(home, "Select All Places", yOffset, function()
    placesDropdown.Text = "All Places"
end)

home.CanvasSize = UDim2.new(0, 0, 0, yOffset + 30)

-- ========
-- EVENTS TAB
-- ========

local events = TabFrames["Events"]

addLabel(events, "Current In-Game Events:", 10)
addLabel(events, "- Egg Hunt Festival (Active)", 35)
addLabel(events, "- Double Weekend Rewards", 60)
addLabel(events, "- Limited-Time Skin Drop", 85)

events.CanvasSize = UDim2.new(0, 0, 0, 130)

-- ========
-- FIND SERVER TAB
-- ========

local findServer = TabFrames["Find Server"]

addLabel(findServer, "Server Search / Private Server Finder", 10)

addButton(findServer, "Scan Public Servers", 35, function()
    print("[Criminal Palestine] Scanning public servers...")
end)

addButton(findServer, "Join Private Server (Input Code)", 70, function()
    print("[Criminal Palestine] Prompt for private server code...")
end)

findServer.CanvasSize = UDim2.new(0, 0, 0, 120)

-- ========
-- CUSTOMIZATION TAB
-- ========

local custom = TabFrames["Customization"]

addLabel(custom, "Customization Settings", 10)
addLabel(custom, "- Theme Color: Blue (default)", 35)
addLabel(custom, "- Notification Sound: Enabled", 60)
addLabel(custom, "- Auto-Update: On", 85)

addButton(custom, "Apply Custom Settings", 110, function()
    print("[Criminal Palestine] Custom settings applied.")
end)

custom.CanvasSize = UDim2.new(0, 0, 0, 150)

-- ========
-- TEST / PLACEHOLDER LOGIC
-- ========

RunService.Heartbeat:Connect(function()

    if autoStealToggle.BackgroundColor3 == Color3.fromRGB(0, 170, 0) then
        print(
            "[Auto Steal] Selected:",
            itemsDropdown.Text,
            areasDropdown.Text,
            placesDropdown.Text
        )
    end

    if autoTradeToggle.BackgroundColor3 == Color3.fromRGB(0, 170, 0) then
        print("[Auto Trade] Test enabled.")
    end

    if autoPlaceEggToggle.BackgroundColor3 == Color3.fromRGB(0, 170, 0) then
        print("[Auto Place Egg] Test enabled.")
    end

    if autoBreakEggToggle.BackgroundColor3 == Color3.fromRGB(0, 170, 0) then
        print("[Auto Break Egg] Test enabled.")
    end
end)

-- ========
-- NOTIFICATION
-- ========

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Criminal Palestine",
        Text = "GUI Loaded Successfully!",
        Duration = 5
    })
end)

-- End of script
