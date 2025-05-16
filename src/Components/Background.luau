--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function BackgroundFrame(props: {
	Size : UDim2,
	child: () -> (),
})
	return React.createElement("Frame", {
		BackgroundColor3 = constants.theme.backgroundColor,
		BackgroundTransparency = constants.theme.backgroundTransparency,
		Size = props.Size,
	}, {
		React.createElement("UICorner", {
			CornerRadius = constants.theme.cornerRadius,
		}),
	})
end

return BackgroundFrame
