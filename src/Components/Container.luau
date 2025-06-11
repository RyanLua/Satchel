--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function ContainerFrame(props: {
	Size: UDim2,
	child: () -> (),
})
	return React.createElement("Frame", {
		Size = props.Size,
		BackgroundTransparency = constants.theme.containerBackgroundTransparency,
		BackgroundColor3 = constants.theme.backgroundColor,
	}, {
		React.createElement("UICorner", {
			CornerRadius = constants.theme.cornerRadiusSmall,
		}),
	}, {
		React.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = constants.theme.containerStrokeColor,
			Transparency = constants.theme.containerStrokeTransparency,
		}),
	})
end

return ContainerFrame
