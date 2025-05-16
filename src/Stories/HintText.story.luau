local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local HintText = require("../Components/HintText")

local controls = {
	text = "Hint action",
	image = "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hint text with icon",
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function()
		return React.createElement(HintText, {
			text = controls.text,
			image = controls.image,
		})
	end,
}
