local SelectionImageObjectMenu = Instance.new("Frame")
SelectionImageObjectMenu.Name = "SelectionImageObjectMenu"
SelectionImageObjectMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SelectionImageObjectMenu.BackgroundTransparency = 1
SelectionImageObjectMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
SelectionImageObjectMenu.BorderSizePixel = 0
SelectionImageObjectMenu.Position = UDim2.fromOffset(3, 0)
SelectionImageObjectMenu.Size = UDim2.new(1, -6, 1, 0)

local UIStroke = Instance.new("UIStroke")
UIStroke.Name = "UIStroke"
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 3

local GradientChild = Instance.new("UIGradient")
GradientChild.Name = "GradientChild"
GradientChild.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86)),
})
GradientChild.Parent = UIStroke

UIStroke.Parent = SelectionImageObjectMenu

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = SelectionImageObjectMenu

return SelectionImageObjectMenu