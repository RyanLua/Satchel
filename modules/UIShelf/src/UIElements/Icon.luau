local Icon = Instance.new("Frame")
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(1, 1)
Icon.BackgroundTransparency = 1
Icon.LayoutOrder = 1
Icon.Size = UDim2.fromOffset(44, 44)

local Background = Instance.new("ImageButton")
Background.Name = "Background"
Background.AnchorPoint = Vector2.new(0, 0.5)
Background.AutomaticSize = Enum.AutomaticSize.X
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.3
Background.Position = UDim2.fromScale(0, 0.5)
Background.Size = UDim2.fromOffset(44, 44)

local Icon1 = Instance.new("ImageLabel")
Icon1.Name = "Icon"
Icon1.AnchorPoint = Vector2.new(0.5, 0.5)
Icon1.BackgroundTransparency = 1
Icon1.Position = UDim2.new(0, 22, 0.5, 0)
Icon1.Size = UDim2.fromOffset(24, 24)
Icon1.Parent = Background

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Background

local StateOverlayRound = Instance.new("Frame")
StateOverlayRound.Name = "StateOverlayRound"
StateOverlayRound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StateOverlayRound.BackgroundTransparency = 1
StateOverlayRound.Size = UDim2.fromScale(1, 1)
StateOverlayRound.ZIndex = 2

local UICorner1 = Instance.new("UICorner")
UICorner1.Name = "UICorner"
UICorner1.CornerRadius = UDim.new(1, 0)
UICorner1.Parent = StateOverlayRound

StateOverlayRound.Parent = Background

local Text = Instance.new("TextLabel")
Text.Name = "Text"
Text.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
Text.Text = "Test, a large label!"
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.TextSize = 14
Text.AutomaticSize = Enum.AutomaticSize.X
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1
Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.fromScale(0, 1)
Text.Visible = false

local Inset = Instance.new("UIPadding")
Inset.Name = "Inset"
Inset.PaddingLeft = UDim.new(0, 42)
Inset.PaddingRight = UDim.new(0, 12)
Inset.Parent = Text

Text.Parent = Background

Background.Parent = Icon

local BadgeContainer = Instance.new("Frame")
BadgeContainer.Name = "BadgeContainer"
BadgeContainer.BackgroundTransparency = 1
BadgeContainer.Size = UDim2.fromScale(1, 1)
BadgeContainer.Visible = false
BadgeContainer.ZIndex = 2
BadgeContainer.Parent = Icon

local MenuContainer = Instance.new("Frame")
MenuContainer.Name = "MenuContainer"
MenuContainer.AnchorPoint = Vector2.new(1, 0)
MenuContainer.AutomaticSize = Enum.AutomaticSize.Y
MenuContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MenuContainer.BackgroundTransparency = 0.3
MenuContainer.Position = UDim2.new(1, 0, 0, 54)
MenuContainer.Size = UDim2.fromOffset(240, 0)
MenuContainer.Visible = false

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"
UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = MenuContainer

local UIPadding = Instance.new("UIPadding")
UIPadding.Name = "UIPadding"
UIPadding.PaddingBottom = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 8)
UIPadding.Parent = MenuContainer

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.XY
ScrollingFrame.ScrollBarThickness = 1
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.AutomaticSize = Enum.AutomaticSize.Y
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Selectable = false
ScrollingFrame.SelectionGroup = false
ScrollingFrame.Size = UDim2.fromScale(1, 0)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

local UISizeConstraint = Instance.new("UISizeConstraint")
UISizeConstraint.Name = "UISizeConstraint"
UISizeConstraint.MaxSize = Vector2.new(math.huge, 232)
UISizeConstraint.Parent = ScrollingFrame

local BottomPadding = Instance.new("Frame")
BottomPadding.Name = "BottomPadding"
BottomPadding.BackgroundTransparency = 1
BottomPadding.LayoutOrder = 1e+04
BottomPadding.Size = UDim2.fromOffset(0, 20)
BottomPadding.Parent = ScrollingFrame

ScrollingFrame.Parent = MenuContainer

MenuContainer.Parent = Icon

return Icon