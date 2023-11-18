local Badge = Instance.new("Frame")
Badge.Name = "Badge"
Badge.AnchorPoint = Vector2.new(1, 0)
Badge.BackgroundTransparency = 1
Badge.Position = UDim2.fromOffset(20, 0)
Badge.Size = UDim2.fromOffset(24, 24)

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.BackgroundColor3 = Color3.fromRGB(35, 37, 39)
Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
Background.BorderSizePixel = 0
Background.Size = UDim2.fromScale(1, 1)
Background.ZIndex = 2

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Background

Background.Parent = Badge

local Inner = Instance.new("Frame")
Inner.Name = "Inner"
Inner.AnchorPoint = Vector2.new(0.5, 0.5)
Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inner.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inner.BorderSizePixel = 0
Inner.Position = UDim2.fromScale(0.5, 0.5)
Inner.Size = UDim2.new(1, -4, 1, -4)
Inner.ZIndex = 3

local UICorner1 = Instance.new("UICorner")
UICorner1.Name = "UICorner"
UICorner1.CornerRadius = UDim.new(1, 0)
UICorner1.Parent = Inner

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "TextLabel"
TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
TextLabel.Text = "0"
TextLabel.TextColor3 = Color3.fromRGB(57, 59, 61)
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.fromScale(0.5, 0.5)
TextLabel.Size = UDim2.fromScale(1, 1)
TextLabel.ZIndex = 100
TextLabel.Parent = Inner

Inner.Parent = Badge

return Badge