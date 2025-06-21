--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function BackgroundFrame(props: {
	Size: UDim2,
	child: () -> (),
})
	return React.createElement("Frame", {
		BackgroundColor3 = Constants.Theme.BackgroundColor,
		BackgroundTransparency = Constants.Theme.BackgroundTransparency,
		Size = props.Size,
	}, {
		React.createElement("UICorner", {
			CornerRadius = Constants.Theme.CornerRadius,
		}),
	})
end

return BackgroundFrame
