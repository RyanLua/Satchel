--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function SearchBarTextBox()
	return React.createElement("Frame", {
		Size = UDim2.new(0, 190, 0, 30),
		BackgroundColor3 = constants.theme.backgroundColor,
		BackgroundTransparency = constants.theme.containerBackgroundTransparency,
	}, {
		React.createElement("UICorner", {
			CornerRadius = constants.theme.cornerRadiusSmall,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = constants.theme.paddingLarge,
			PaddingLeft = constants.theme.paddingLarge,
			PaddingRight = UDim.new(0, 28),
			PaddingTop = constants.theme.paddingLarge,
		}),
	}, {
		React.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = constants.theme.containerStrokeColor,
			Transparency = constants.theme.containerStrokeTransparency,
		}),
	}, {
		React.createElement("TextBox", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Font = constants.theme.font,
			Text = "",
			PlaceholderText = "Search",
			TextColor3 = constants.theme.textColor,
			TextSize = constants.theme.textSize,
			TextStrokeTransparency = constants.theme.textStrokeTransparency,
			TextStrokeColor3 = constants.theme.textStrokeColor,
			TextXAlignment = Enum.TextXAlignment.Left,
		}),
	})
end

return SearchBarTextBox
