local Tooltip = Instance.new("CanvasGroup")
Tooltip.Name = "Tooltip"
Tooltip.AnchorPoint = Vector2.new(0.5, 0)
Tooltip.AutomaticSize = Enum.AutomaticSize.XY
Tooltip.BackgroundTransparency = 1
Tooltip.BorderSizePixel = 0
Tooltip.Position = UDim2.fromOffset(0, 0)
Tooltip.Size = UDim2.fromOffset(32, 53)
Tooltip.Visible = false

local Box = Instance.new("Frame")
Box.Name = "Box"
Box.AutomaticSize = Enum.AutomaticSize.XY
Box.BackgroundColor3 = Color3.fromRGB(101, 102, 104)
Box.Position = UDim2.fromOffset(4, 7)
Box.ZIndex = 2

local Header = Instance.new("TextLabel")
Header.Name = "Header"
Header.FontFace = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Medium,
	Enum.FontStyle.Normal
)
Header.Text = "dsadasdsada"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 14
Header.TextTruncate = Enum.TextTruncate.AtEnd
Header.TextWrapped = true
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.AutomaticSize = Enum.AutomaticSize.X
Header.BackgroundTransparency = 1
Header.LayoutOrder = 1
Header.Size = UDim2.fromOffset(0, 16)
Header.Parent = Box

local Layout = Instance.new("UIListLayout")
Layout.Name = "Layout"
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Box

local Corner = Instance.new("UICorner")
Corner.Name = "Corner"
Corner.Parent = Box

local Padding = Instance.new("UIPadding")
Padding.Name = "Padding"
Padding.PaddingBottom = UDim.new(0, 12)
Padding.PaddingLeft = UDim.new(0, 12)
Padding.PaddingRight = UDim.new(0, 12)
Padding.PaddingTop = UDim.new(0, 12)
Padding.Parent = Box

local Hotkeys = Instance.new("Frame")
Hotkeys.Name = "Hotkeys"
Hotkeys.AutomaticSize = Enum.AutomaticSize.Y
Hotkeys.BackgroundTransparency = 1
Hotkeys.LayoutOrder = 3
Hotkeys.Size = UDim2.fromScale(1, 0)
Hotkeys.Visible = false

local Layout1 = Instance.new("UIListLayout")
Layout1.Name = "Layout"
Layout1.Padding = UDim.new(0, 6)
Layout1.FillDirection = Enum.FillDirection.Vertical
Layout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout1.HorizontalFlex = Enum.UIFlexAlignment.None
Layout1.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
Layout1.VerticalFlex = Enum.UIFlexAlignment.None
Layout1.SortOrder = Enum.SortOrder.LayoutOrder
Layout1.Parent = Hotkeys

local Var_1 = Instance.new("ImageLabel")
Var_1.Name = "1"
Var_1.Image = "rbxasset://textures/ui/Controls/key_single.png"
Var_1.ImageTransparency = 0.7
Var_1.ScaleType = Enum.ScaleType.Slice
Var_1.SliceCenter = Rect.new(5, 5, 23, 24)
Var_1.AutomaticSize = Enum.AutomaticSize.X
Var_1.BackgroundTransparency = 1
Var_1.LayoutOrder = 1
Var_1.Size = UDim2.fromOffset(0, 30)

local Inset = Instance.new("UIPadding")
Inset.Name = "Inset"
Inset.PaddingLeft = UDim.new(0, 8)
Inset.PaddingRight = UDim.new(0, 8)
Inset.Parent = Var_1

local LabelContent = Instance.new("TextLabel")
LabelContent.Name = "LabelContent"
LabelContent.FontFace = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Medium,
	Enum.FontStyle.Normal
)
LabelContent.Text = ""
LabelContent.TextColor3 = Color3.fromRGB(189, 190, 190)
LabelContent.TextSize = 14
LabelContent.AutomaticSize = Enum.AutomaticSize.X
LabelContent.BackgroundTransparency = 1
LabelContent.Position = UDim2.fromOffset(0, -1)
LabelContent.Size = UDim2.fromScale(1, 1)
LabelContent.Parent = Var_1

Var_1.Parent = Hotkeys

Hotkeys.Parent = Box

Box.Parent = Tooltip

local Caret = Instance.new("ImageLabel")
Caret.Name = "Caret"
Caret.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
Caret.ImageColor3 = Color3.fromRGB(101, 102, 104)
Caret.ImageRectOffset = Vector2.new(260, 440)
Caret.ImageRectSize = Vector2.new(16, 8)
Caret.AnchorPoint = Vector2.new(0.5, 0.5)
Caret.BackgroundTransparency = 1
Caret.Position = UDim2.new(0, 0, 0, 4)
Caret.Rotation = 180
Caret.Size = UDim2.fromOffset(16, 8)
Caret.ZIndex = 2
Caret.Parent = Tooltip

local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageRectOffset = Vector2.new(217, 486)
DropShadow.ImageRectSize = Vector2.new(25, 25)
DropShadow.ImageTransparency = 0.5
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(12, 12, 13, 13)
DropShadow.BackgroundTransparency = 1
DropShadow.Position = UDim2.fromOffset(0, 5)
DropShadow.Size = UDim2.fromOffset(32, 48)
DropShadow.Parent = Tooltip

return Tooltip