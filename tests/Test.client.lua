--[[
	Name: Satchel
	Description: Loads the Satchel backpack system.
	GitHub: https://github.com/RyanLua/Satchel
]]

--[[
	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEZ = require(ReplicatedStorage:WaitForChild("testez"))

local Satchel = script:WaitForChild("Satchel")

require(Satchel) -- Initialize Satchel
TestEZ.TestBootstrap:run({ Satchel }) -- Run Tests
