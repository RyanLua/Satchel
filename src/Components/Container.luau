--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function ContainerFrame(props: {
	Size: UDim2,
	child: () -> (),
})
	return React.createElement("Frame", {
		Size = props.Size,
		BackgroundTransparency = Constants.Theme.ContainerBackgroundTransparency,
		BackgroundColor3 = Constants.Theme.BackgroundColor,
	}, {
		React.createElement("UICorner", {
			CornerRadius = Constants.Theme.CornerRadiusSmall,
		}),
	}, {
		React.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Constants.Theme.ContainerStrokeColor,
			Transparency = Constants.Theme.ContainerStrokeTransparency,
		}),
	})
end

return ContainerFrame
