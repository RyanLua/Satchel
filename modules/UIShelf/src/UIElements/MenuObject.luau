local MenuObject = Instance.new("ImageButton")
MenuObject.Name = "MenuObject"
MenuObject.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MenuObject.BackgroundTransparency = 1
MenuObject.BorderSizePixel = 0
MenuObject.LayoutOrder = 13
MenuObject.Size = UDim2.new(1, 0, 0, 56)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Parent = MenuObject

local StyledTextLabel = Instance.new("TextLabel")
StyledTextLabel.Name = "StyledTextLabel"
StyledTextLabel.FontFace = Font.new(
	"rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Medium,
	Enum.FontStyle.Normal
)
StyledTextLabel.LineHeight = 1.4
StyledTextLabel.RichText = true
StyledTextLabel.Text = ""
StyledTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StyledTextLabel.TextScaled = true
StyledTextLabel.TextSize = 19
StyledTextLabel.TextTruncate = Enum.TextTruncate.AtEnd
StyledTextLabel.TextWrapped = true
StyledTextLabel.TextXAlignment = Enum.TextXAlignment.Left
StyledTextLabel.BackgroundTransparency = 1
StyledTextLabel.Size = UDim2.fromOffset(101, 21)

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.MaxTextSize = 19
UITextSizeConstraint.MinTextSize = 14
UITextSizeConstraint.Parent = StyledTextLabel

StyledTextLabel.Parent = MenuObject

local UIPadding = Instance.new("UIPadding")
UIPadding.Name = "UIPadding"
UIPadding.PaddingLeft = UDim.new(0, 24)
UIPadding.PaddingRight = UDim.new(0, 8)
UIPadding.Parent = MenuObject

local IconHost = Instance.new("Frame")
IconHost.Name = "IconHost"
IconHost.BackgroundTransparency = 1
IconHost.BorderSizePixel = 0
IconHost.LayoutOrder = 13
IconHost.Size = UDim2.fromOffset(44, 44)
IconHost.ZIndex = 13

local IntegrationIconFrame = Instance.new("Frame")
IntegrationIconFrame.Name = "IntegrationIconFrame"
IntegrationIconFrame.BackgroundTransparency = 1
IntegrationIconFrame.BorderSizePixel = 0
IntegrationIconFrame.Size = UDim2.fromScale(1, 1)

local UIListLayout1 = Instance.new("UIListLayout")
UIListLayout1.Name = "UIListLayout"
UIListLayout1.FillDirection = Enum.FillDirection.Horizontal
UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout1.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout1.Parent = IntegrationIconFrame

local IntegrationIcon = Instance.new("ImageLabel")
IntegrationIcon.Name = "IntegrationIcon"
IntegrationIcon.BackgroundTransparency = 1
IntegrationIcon.Size = UDim2.fromOffset(36, 36)
IntegrationIcon.Parent = IntegrationIconFrame

IntegrationIconFrame.Parent = IconHost

local SelectedHighlighter = Instance.new("Frame")
SelectedHighlighter.Name = "SelectedHighlighter"
SelectedHighlighter.AnchorPoint = Vector2.new(0.5, 0.5)
SelectedHighlighter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SelectedHighlighter.BackgroundTransparency = 0.9
SelectedHighlighter.BorderSizePixel = 0
SelectedHighlighter.Position = UDim2.fromScale(0.5, 0.5)
SelectedHighlighter.Size = UDim2.fromOffset(36, 36)
SelectedHighlighter.Visible = false

local Corner = Instance.new("UICorner")
Corner.Name = "corner"
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = SelectedHighlighter

SelectedHighlighter.Parent = IconHost

local Highlighter = Instance.new("Frame")
Highlighter.Name = "Highlighter"
Highlighter.AnchorPoint = Vector2.new(0.5, 0.5)
Highlighter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Highlighter.BackgroundTransparency = 0.9
Highlighter.BorderSizePixel = 0
Highlighter.Position = UDim2.fromScale(0.5, 0.5)
Highlighter.Size = UDim2.fromOffset(36, 36)
Highlighter.Visible = false

local Corner1 = Instance.new("UICorner")
Corner1.Name = "corner"
Corner1.CornerRadius = UDim.new(1, 0)
Corner1.Parent = Highlighter

Highlighter.Parent = IconHost

local Var_5 = Instance.new("Frame")
Var_5.Name = "5"
Var_5.BackgroundTransparency = 1
Var_5.Size = UDim2.fromScale(1, 1)
Var_5.ZIndex = 2
Var_5.Parent = IconHost

IconHost.Parent = MenuObject

return MenuObject