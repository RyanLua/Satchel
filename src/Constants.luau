--!strict

--[[
	Constants for variables.
--]]

local Constants = {
	Theme = {
		-- Spacing
		Thickness = 5,
		Padding = UDim.new(0, 5),
		PaddingLarge = UDim.new(0, 8),
		CornerRadius = UDim.new(0, 8),
		CornerRadiusSmall = UDim.new(0, 3), -- padding - cornerRadius

		-- Font
		Font = Enum.Font.BuilderSansMedium,
		FontSmall = Enum.Font.BuilderSansExtraBold,
		TextSize = 18,
		TextSizeLarge = 24,
		TextSizeSmall = 14,

		-- Colors
		BackgroundColor = Color3.fromRGB(25, 27, 29),
		TooltipBackgroundColor = Color3.fromRGB(38, 40, 48),
		ContainerStrokeColor = Color3.fromRGB(255, 255, 255),
		TextColor = Color3.fromRGB(255, 255, 255),
		TextStrokeColor = Color3.fromRGB(0, 0, 0),
		ContainerTextColor = Color3.fromRGB(255, 255, 255),
		EquippedColor = Color3.fromRGB(255, 255, 255),

		-- Transparency
		BackgroundTransparency = 0.3,
		ContainerBackgroundTransparency = 0.2,
		TooltipBackgroundTransparency = 0,
		TextStrokeTransparency = 0.5,
		ContainerTextTransparency = 0.5,
		ContainerStrokeTransparency = 0.8,
	},
}

return Constants
