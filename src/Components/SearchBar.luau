--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function SearchBarTextBox()
	return React.createElement("Frame", {
		Size = UDim2.new(0, 190, 0, 30),
		BackgroundColor3 = Constants.Theme.BackgroundColor,
		BackgroundTransparency = Constants.Theme.ContainerBackgroundTransparency,
	}, {
		React.createElement("UICorner", {
			CornerRadius = Constants.Theme.CornerRadiusSmall,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = Constants.Theme.PaddingLarge,
			PaddingLeft = Constants.Theme.PaddingLarge,
			PaddingRight = UDim.new(0, 28),
			PaddingTop = Constants.Theme.PaddingLarge,
		}),
	}, {
		React.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Constants.Theme.ContainerStrokeColor,
			Transparency = Constants.Theme.ContainerStrokeTransparency,
		}),
	}, {
		React.createElement("TextBox", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Font = Constants.Theme.Font,
			Text = "",
			PlaceholderText = "Search",
			TextColor3 = Constants.Theme.TextColor,
			TextSize = Constants.Theme.TextSize,
			TextStrokeTransparency = Constants.Theme.TextStrokeTransparency,
			TextStrokeColor3 = Constants.Theme.TextStrokeColor,
			TextXAlignment = Enum.TextXAlignment.Left,
		}),
	})
end

return SearchBarTextBox
