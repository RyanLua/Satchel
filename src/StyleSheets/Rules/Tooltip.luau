-- TextLabel rule
local textLabelRule = Instance.new("StyleRule")
textLabelRule.Selector = "TextLabel"
-- textLabelRule.Parent = designSheet

-- Tooltip rule
local tooltipRule = Instance.new("StyleRule")
tooltipRule.Selector = ".Tooltip"
tooltipRule.Parent = textLabelRule

tooltipRule:SetProperties({
	["AnchorPoint"] = UDim.new(1, 0.5),
	["AutomaticSize"] = Enum.AutomaticSize.XY,
	["BackgroundColor3"] = "$ToolTipBackgroundColor",
	["BackgroundTransparency"] = "$ToolTipBackgroundTransparency",
	["FontFace"] = "$ToolTipFontFace",
	["Position"] = UDim2.new(0.5, 0, 0.5, -10),
	["Size"] = UDim2.new(0, 0, 0, 0),
	["TextColor3"] = "$ToolTipTextColor",
	["TextSize"] = "$ToolTipTextSize",
})

-- Pseudo instances
local uiCorner = Instance.new("StyleRule")
uiCorner.Selector = "::UICorner"
uiCorner.Parent = tooltipRule

uiCorner:SetProperties({
	["CornerRadius"] = "$ToolTipCornerRadius",
})

local uiPadding = Instance.new("StyleRule")
uiPadding.Selector = "::UIPadding"
uiPadding.Parent = tooltipRule

uiPadding:SetProperties({
	["PaddingBottom"] = "$ToolTipPadding",
	["PaddingLeft"] = "$ToolTipPadding",
	["PaddingRight"] = "$ToolTipPadding",
	["PaddingTop"] = "$ToolTipPadding",
})
