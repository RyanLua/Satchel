local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Tooltip = require("../Components/Tooltip")

local controls = {
	text = "Tool Tip",
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "A tooltip for a tool slot",
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props: Props)
		return React.createElement(Tooltip, {
			text = props.controls.text,
		})
	end,
}
