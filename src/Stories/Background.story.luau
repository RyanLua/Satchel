--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Background = require("../Components/Background")

return {
	summary = "Base background frame",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Background, {
			Size = UDim2.new(0, 200, 0, 200),
		})
	end,
}
