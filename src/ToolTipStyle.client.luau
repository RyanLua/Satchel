-- Parent this script to a ScreenGui under StarterGui.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local screenGui = script.Parent

-- DesignSheet
local sheet = Instance.new("StyleSheet")
sheet.Parent = ReplicatedStorage

-- Configure rule
local toolTipRule = Instance.new("StyleRule")
toolTipRule.Selector = "TextLabel" -- Class selector
toolTipRule.Parent = sheet

-- Set rule properties
toolTipRule:SetProperties({
	["AnchorPoint"] = Vector2.new(0.5, 1),
	["AutomaticSize"] = Enum.AutomaticSize.XY,
	["BackgroundColor3"] = "$ToolTipBackgroundColor",
	["FontFace"] = "$ToolTipFontFace",
	["Position"] = UDim2.new(0.5, 0, 1, 0),
	["Size"] = UDim2.new(0, 0, 0, 0),
	["TextColor3"] = "$ToolTipTextColor",
	["TextSize"] = "$ToolTipTextSize",
})

-- Create a UI
local button = Instance.new("TextButton")
button.Text = "Main Menu"
button.Parent = screenGui

-- Apply styling to UI
local link = Instance.new("StyleLink")
link.Parent = screenGui
link.StyleSheet = sheet
