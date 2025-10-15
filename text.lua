-- // ⚙️ Thêm hỗ trợ Slider cho AN SCRIPT HUB
function OrionLib:AddSlider(data)
    local SliderFrame = Instance.new("Frame")
    local SliderLabel = Instance.new("TextLabel")
    local SliderBar = Instance.new("Frame")
    local SliderFill = Instance.new("Frame")
    local SliderValue = Instance.new("TextLabel")

    SliderFrame.Name = data.Name or "Slider"
    SliderFrame.Size = UDim2.new(1, -10, 0, 50)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = data.Tab or OrionLib.LastTab

    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 5, 0, 0)
    SliderLabel.Size = UDim2.new(1, -10, 0, 20)
    SliderLabel.Font = Enum.Font.GothamBold
    SliderLabel.Text = data.Name or "Slider"
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 14
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

    SliderBar.Parent = SliderFrame
    SliderBar.Position = UDim2.new(0, 5, 0, 25)
    SliderBar.Size = UDim2.new(1, -10, 0, 6)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.BorderSizePixel = 0
    SliderBar.Name = "SliderBar"

    SliderFill.Parent = SliderBar
    SliderFill.BackgroundColor3 = data.Color or Color3.fromRGB(255, 170, 0)
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.BorderSizePixel = 0
    SliderFill.Name = "SliderFill"

    SliderValue.Parent = SliderFrame
    SliderValue.BackgroundTransparency = 1
    SliderValue.Position = UDim2.new(1, -60, 0, 0)
    SliderValue.Size = UDim2.new(0, 50, 0, 20)
    SliderValue.Font = Enum.Font.GothamBold
    SliderValue.Text = tostring(data.Default or 0)
    SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderValue.TextSize = 14
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right

    -- 🧮 Giá trị
    local Min = data.Min or 0
    local Max = data.Max or 100
    local Default = data.Default or 0
    local Current = Default

    -- Đặt giá trị mặc định
    SliderFill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)

    -- Kéo thanh
    local UserInputService = game:GetService("UserInputService")
    local dragging = false

    local function UpdateValue(inputX)
        local barAbsPos = SliderBar.AbsolutePosition.X
        local barAbsSize = SliderBar.AbsoluteSize.X
        local percent = math.clamp((inputX - barAbsPos) / barAbsSize, 0, 1)
        Current = math.floor(Min + (Max - Min) * percent)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderValue.Text = tostring(Current)
        if data.Callback then
            pcall(data.Callback, Current)
        end
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            UpdateValue(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateValue(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end
