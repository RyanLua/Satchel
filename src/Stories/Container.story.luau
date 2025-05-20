--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Container = require("../Components/Container")

return {
	summary = "Base container frame",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Container, {
			Size = UDim2.new(0, 200, 0, 200),
		})
	end,
}
