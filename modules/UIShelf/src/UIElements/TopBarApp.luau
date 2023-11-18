local TopBarApp = Instance.new("ScreenGui")
TopBarApp.Name = "TopBarApp"
TopBarApp.DisplayOrder = 1e+09
TopBarApp.IgnoreGuiInset = true
TopBarApp.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
TopBarApp.ResetOnSpawn = false

local TopBarFrame = Instance.new("Frame")
TopBarFrame.Name = "TopBarFrame"
TopBarFrame.AnchorPoint = Vector2.new(0, 1)
TopBarFrame.BackgroundTransparency = 1
TopBarFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
TopBarFrame.Position = UDim2.new(0, 0, 1, 2)
TopBarFrame.Size = UDim2.new(1, 0, 0, 48)

local LeftFrame = Instance.new("Frame")
LeftFrame.Name = "LeftFrame"
LeftFrame.BackgroundTransparency = 1
LeftFrame.Position = UDim2.fromOffset(12, 0)
LeftFrame.Size = UDim2.new(0.5, -12, 1, 0)

local Layout = Instance.new("UIListLayout")
Layout.Name = "Layout"
Layout.Padding = UDim.new(0, 12)
Layout.FillDirection = Enum.FillDirection.Horizontal
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = LeftFrame

LeftFrame.Parent = TopBarFrame

local RightFrame = Instance.new("Frame")
RightFrame.Name = "RightFrame"
RightFrame.BackgroundTransparency = 1
RightFrame.Position = UDim2.fromScale(0.5, 0)
RightFrame.Size = UDim2.new(0.5, -12, 1, 0)

local Layout1 = Instance.new("UIListLayout")
Layout1.Name = "Layout"
Layout1.Padding = UDim.new(0, 12)
Layout1.FillDirection = Enum.FillDirection.Horizontal
Layout1.HorizontalAlignment = Enum.HorizontalAlignment.Right
Layout1.SortOrder = Enum.SortOrder.LayoutOrder
Layout1.Parent = RightFrame

RightFrame.Parent = TopBarFrame

TopBarFrame.Parent = TopBarApp

return TopBarApp