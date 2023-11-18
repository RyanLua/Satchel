local SelectionImageObject = Instance.new("Frame")
SelectionImageObject.Name = "SelectionImageObject"
SelectionImageObject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SelectionImageObject.BackgroundTransparency = 1
SelectionImageObject.BorderColor3 = Color3.fromRGB(0, 0, 0)
SelectionImageObject.BorderSizePixel = 0
SelectionImageObject.Size = UDim2.new(1, 0, 0, 44)

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

UIStroke.Parent = SelectionImageObject

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = SelectionImageObject

return SelectionImageObject