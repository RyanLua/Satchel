--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local SearchBar = require("../Components/SearchBar")

return {
	summary = "A search bar for finding tools",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(SearchBar)
	end,
}
