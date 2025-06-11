--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Slot = require("../Components/HintSlot")

local controls = {
	IsTenFootInterface = false,
	image = "rbxasset://textures/ui/Controls/DesignSystem/ButtonR1.png",
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "A hint that goes in the tool slot",
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props: Props)
		return React.createElement(Slot, {
			IsTenFootInterface = props.controls.IsTenFootInterface,
			image = props.controls.image,
		})
	end,
}
