--!strict

--[[
	Name: SatchelScript
	Version: 0.1.0
	Description: Satchel is a modern open-source alternative to Roblox's default backpack. Satchel aims to be more customizable and easier to use than the default backpack while still having a "vanilla" feel.
	By: @WinnersTakesAll on Roblox & @RyanLua on GitHub

	Acknowledgements (@Roblox):
		@OnlyTwentyCharacters, @SolarCrane -- For creating the CoreGui script
		@thebrickplanetboy -- For allowing me to republish his fork of the backpack system.
		@ForeverHD -- Making Topbar Plus and open-sourcing it for everyone to use

	GitHub: https://github.com/RyanLua/Satchel
	DevForum: https://devforum.roblox.com/t/2451549
]]

--[[
	Satchel, a modern open-source alternative to Roblox's default backpack.
	Copyright (C) 2023  RyanLua

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as published
	by the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui

local BackpackScript = {}

BackpackScript.OpenClose = nil -- Function to toggle open/close
BackpackScript.IsOpen = false
BackpackScript.StateChanged = Instance.new("BindableEvent") -- Fires after any open/close, passes IsNowOpen

BackpackScript.ModuleName = "Backpack"
BackpackScript.KeepVRTopbarOpen = true
BackpackScript.VRIsExclusive = true
BackpackScript.VRClosesNonExclusive = true

local targetScript = script.Parent

local GetFFlagUseDesignSystemGamepadIcons = true

local ICON_SIZE = 60 -- Pixels
local FONT_SIZE = targetScript:GetAttribute("TextSize") or 14
local ICON_BUFFER = 5

-- Legacy behavior for backpack.
local LEGACY_PADDING = targetScript:GetAttribute("InsetIconPadding") -- Instead of the icon taking up the full slot, it will be padded on each side.
local LEGACY_EDGE = not targetScript:GetAttribute("OutlineEquipBorder") or false -- Instead of the edge selection being inset, it will be on the outlined.  LEGACY_PADDING must be enabled for this to work or this will do nothing

-- Inventory
local BACKGROUND_FADE = targetScript:GetAttribute("BackgroundTransparency") or 0.3
local BACKGROUND_COLOR = targetScript:GetAttribute("BackgroundColor3") or Color3.new(25 / 255, 27 / 255, 29 / 255)
local BACKGROUND_CORNER_RADIUS = targetScript:GetAttribute("CornerRadius") or UDim.new(0, 8)

-- Slot colors, thickness, etc.
local SLOT_DRAGGABLE_COLOR = targetScript:GetAttribute("BackgroundColor3") or Color3.new(25 / 255, 27 / 255, 29 / 255)
local SLOT_EQUIP_COLOR = Color3.new(0 / 255, 162 / 255, 1)
local SLOT_EQUIP_THICKNESS = targetScript:GetAttribute("EquipBorderSizePixel") or 5 -- Relative
local SLOT_FADE_LOCKED = targetScript:GetAttribute("BackgroundTransparency") or 0.3 -- Locked means undraggable
local SLOT_BORDER_COLOR = Color3.new(1, 1, 1) -- Appears when dragging
local SLOT_CORNER_RADIUS = targetScript:GetAttribute("CornerRadius") or UDim.new(0, 8)

-- Tooltip
local TOOLTIP_PADDING = 4
local TOOLTIP_HEIGHT = 16
local TOOLTIP_OFFSET = -5 -- From to
local TOOLTIP_CORNER_RADIUS = SLOT_CORNER_RADIUS - UDim.new(0, 5) or UDim.new(0, 3)
local TOOLTIP_BACKGROUND_COLOR = targetScript:GetAttribute("BackgroundColor3")
	or Color3.new(25 / 255, 27 / 255, 29 / 255)

--
local ARROW_IMAGE_OPEN = "rbxasset://textures/ui/TopBar/inventoryOn.png"
local ARROW_IMAGE_CLOSE = "rbxasset://textures/ui/TopBar/inventoryOff.png"
local ARROW_HOTKEY = { Enum.KeyCode.Backquote, Enum.KeyCode.DPadUp } --TODO: Hookup '~' too?
local ICON_MODULE = script.Icon

-- Hotbar slots
local HOTBAR_SLOTS_FULL = 10 -- 10 is the max
local HOTBAR_SLOTS_VR = 6
local HOTBAR_SLOTS_MINI = 6 -- Mobile gets 6 slots instead of default 3 it had before
local HOTBAR_SLOTS_WIDTH_CUTOFF = 1024 -- Anything smaller is MINI

local INVENTORY_ROWS_FULL = 4
local INVENTORY_ROWS_VR = 3
local INVENTORY_ROWS_MINI = 2
local INVENTORY_HEADER_SIZE = 40
local INVENTORY_ARROWS_BUFFER_VR = 40

-- Search
local SEARCH_BUFFER = 5
local SEARCH_WIDTH = 200
local SEARCH_CORNER_RADIUS = SLOT_CORNER_RADIUS - UDim.new(0, 5) or UDim.new(0, 3)
local SEARCH_ICON_X = "rbxasset://textures/ui/InspectMenu/x.png"
local SEARCH_PLACEHOLDER = "Search"
-- local SEARCH_PLACEHOLDER_COLOR = Color3.fromRGB(1, 1, 1)

local SEARCH_TEXT_COLOR = targetScript:GetAttribute("TextColor3") or Color3.new(1, 1, 1)
local TEXT_COLOR = targetScript:GetAttribute("TextColor3") or Color3.new(1, 1, 1)
local TEXT_FADE = targetScript:GetAttribute("TextStrokeTransparency") or 0.5
local TEXT_FADE_COLOR = targetScript:GetAttribute("TextStrokeColor3") or Color3.new(0, 0, 0)
local SEARCH_TEXT_STROKE_COLOR = targetScript:GetAttribute("TextStrokeColor3") or Color3.new(0, 0, 0)
local SEARCH_TEXT = ""

local SEARCH_TEXT_OFFSET = 8
local SEARCH_BACKGROUND_COLOR = Color3.new(25 / 255, 27 / 255, 29 / 255)
local SEARCH_BACKGROUND_FADE = 0.20

local SEARCH_BORDER_THICKNESS = 1
local SEARCH_BORDER_FADE = 0.8
local SEARCH_BORDER_COLOR = Color3.new(1, 1, 1)

local DOUBLE_CLICK_TIME = 0.5
local ZERO_KEY_VALUE = Enum.KeyCode.Zero.Value
local DROP_HOTKEY_VALUE = Enum.KeyCode.Backspace.Value

local GAMEPAD_INPUT_TYPES = { -- These are the input types that will be used for gamepad
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true,
}

-- Topbar logic
local TopbarPlusReference = ReplicatedStorage:FindFirstChild("TopbarPlusReference")
local BackpackEnabled = true

if TopbarPlusReference then
	ICON_MODULE = TopbarPlusReference.Value
end
local BackpackGui = Instance.new("ScreenGui")
BackpackGui.DisplayOrder = 120
BackpackGui.IgnoreGuiInset = true
BackpackGui.ResetOnSpawn = false
BackpackGui.Name = "BackpackGui"
BackpackGui.Parent = PlayerGui

local Icon = require(ICON_MODULE)

local IsTenFootInterface = GuiService:IsTenFootInterface()

if IsTenFootInterface then
	ICON_SIZE = 100
	FONT_SIZE = 24
end

local GamepadActionsBound = false

local GetScreenResolution = function(): Vector2
	local CurrentCamera = workspace.CurrentCamera
	local ViewportSize = CurrentCamera.ViewportSize
	return ViewportSize
end

local IS_PHONE = UserInputService.TouchEnabled and GetScreenResolution().X < HOTBAR_SLOTS_WIDTH_CUTOFF

local Player = Players.LocalPlayer

local MainFrame = nil
local HotbarFrame = nil
local InventoryFrame = nil
local VRInventorySelector = nil
local ScrollingFrame: ScrollingFrame = nil
local UIGridFrame: Frame = nil
local UIGridLayout: UIGridLayout = nil
local ScrollUpInventoryButton = nil
local ScrollDownInventoryButton = nil

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local Backpack = Player:WaitForChild("Backpack")

local InventoryIcon = Icon.new()
InventoryIcon:setImage(ARROW_IMAGE_CLOSE, "deselected")
InventoryIcon:setImage(ARROW_IMAGE_OPEN, "selected")
-- InventoryIcon:setTheme(Themes.BlueGradient)
InventoryIcon:bindToggleKey(ARROW_HOTKEY[1], ARROW_HOTKEY[2])
InventoryIcon:setName("InventoryIcon")
InventoryIcon:setImageYScale(1.12)
InventoryIcon:setOrder(-5)
InventoryIcon.deselectWhenOtherIconSelected = false

local Slots = {} -- List of all Slots by index
local LowestEmptySlot = nil
local SlotsByTool = {} -- Map of Tools to their assigned Slots
local HotkeyFns = {} -- Map of KeyCode values to their assigned behaviors
local Dragging = {} -- Only used to check if anything is being dragged, to disable other input
local FullHotbarSlots = 0 -- Now being used to also determine whether or not LB and RB on the gamepad are enabled.
local StarterToolFound = false -- Special handling is required for the gear currently equipped on the site
local WholeThingEnabled = false
local TextBoxFocused = false -- ANY TextBox, not just the search box
local ViewingSearchResults = false -- If the results of a search are currently being viewed
-- local HotkeyStrings = {} -- Used for eating/releasing hotkeys
local CharConns = {} -- Holds character Connections to be cleared later
local GamepadEnabled = false -- determines if our gui needs to be gamepad friendly

local IsVR = VRService.VREnabled -- Are we currently using a VR device?
local NumberOfHotbarSlots = IsVR and HOTBAR_SLOTS_VR or (IS_PHONE and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL) -- Number of slots shown at the bottom
local NumberOfInventoryRows = IsVR and INVENTORY_ROWS_VR or (IS_PHONE and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL) -- How many rows in the popped-up inventory
local BackpackPanel = nil
local lastEquippedSlot = nil

local function EvaluateBackpackPanelVisibility(enabled: boolean): boolean
	return enabled and InventoryIcon.enabled and BackpackEnabled and VRService.VREnabled
end

local function ShowVRBackpackPopup(): ()
	if BackpackPanel and EvaluateBackpackPanelVisibility(true) then
		BackpackPanel:ForceShowForSeconds(2)
	end
end

local function NewGui(className: string, objectName: string): any
	local newGui: TextLabel = Instance.new(className)
	newGui.Name = objectName
	newGui.BackgroundColor3 = Color3.new(0, 0, 0)
	newGui.BackgroundTransparency = 1
	newGui.BorderColor3 = Color3.new(0, 0, 0)
	newGui.Size = UDim2.new(1, 0, 1, 0)
	if className:match("Text") then
		newGui.TextColor3 = TEXT_COLOR
		newGui.Text = ""
		newGui.TextStrokeTransparency = TEXT_FADE
		newGui.TextStrokeColor3 = TEXT_FADE_COLOR
		newGui.Font = Enum.Font.GothamMedium
		newGui.TextSize = FONT_SIZE
		newGui.TextWrapped = true
		if className == "TextButton" then
			newGui.Font = Enum.Font.Gotham
			newGui.BorderSizePixel = 1
		end
	end
	return newGui
end

local function FindLowestEmpty(): number?
	for i = 1, NumberOfHotbarSlots do
		local slot = Slots[i]
		if not slot.Tool then
			return slot
		end
	end
	return nil
end

-- local function isInventoryEmpty(): boolean
-- 	for i = NumberOfHotbarSlots + 1, #Slots do
-- 		local slot = Slots[i]
-- 		if slot and slot.Tool then
-- 			return false
-- 		end
-- 	end
-- 	return true
-- end

local function UseGazeSelection(): ()
	return UserInputService.VREnabled
end

local function AdjustHotbarFrames(): ()
	local inventoryOpen = InventoryFrame.Visible -- (Show all)
	local visualTotal = inventoryOpen and NumberOfHotbarSlots or FullHotbarSlots
	local visualIndex = 0

	for i = 1, NumberOfHotbarSlots do
		local slot = Slots[i]
		if slot.Tool or inventoryOpen then
			visualIndex = visualIndex + 1
			slot:Readjust(visualIndex, visualTotal)
			slot.Frame.Visible = true
		else
			slot.Frame.Visible = false
		end
	end
end

local function UpdateScrollingFrameCanvasSize(): ()
	local countX = math.floor(ScrollingFrame.AbsoluteSize.X / (ICON_SIZE + ICON_BUFFER))
	local maxRow = math.ceil((#UIGridFrame:GetChildren() - 1) / countX)
	local canvasSizeY = maxRow * (ICON_SIZE + ICON_BUFFER) + ICON_BUFFER
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, canvasSizeY)
end

local function AdjustInventoryFrames(): ()
	for i = NumberOfHotbarSlots + 1, #Slots do
		local slot = Slots[i]
		slot.Frame.LayoutOrder = slot.Index
		slot.Frame.Visible = (slot.Tool ~= nil)
	end
	UpdateScrollingFrameCanvasSize()
end

local function UpdateBackpackLayout(): ()
	HotbarFrame.Size = UDim2.new(
		0,
		ICON_BUFFER + (NumberOfHotbarSlots * (ICON_SIZE + ICON_BUFFER)),
		0,
		ICON_BUFFER + ICON_SIZE + ICON_BUFFER
	)
	HotbarFrame.Position = UDim2.new(0.5, -HotbarFrame.Size.X.Offset / 2, 1, -HotbarFrame.Size.Y.Offset)
	InventoryFrame.Size = UDim2.new(
		0,
		HotbarFrame.Size.X.Offset,
		0,
		(HotbarFrame.Size.Y.Offset * NumberOfInventoryRows)
			+ INVENTORY_HEADER_SIZE
			+ (IsVR and 2 * INVENTORY_ARROWS_BUFFER_VR or 0)
	)
	InventoryFrame.Position = UDim2.new(
		0.5,
		-InventoryFrame.Size.X.Offset / 2,
		1,
		HotbarFrame.Position.Y.Offset - InventoryFrame.Size.Y.Offset
	)

	ScrollingFrame.Size = UDim2.new(
		1,
		ScrollingFrame.ScrollBarThickness + 1,
		1,
		-INVENTORY_HEADER_SIZE - (IsVR and 2 * INVENTORY_ARROWS_BUFFER_VR or 0)
	)
	ScrollingFrame.Position = UDim2.new(0, 0, 0, INVENTORY_HEADER_SIZE + (IsVR and INVENTORY_ARROWS_BUFFER_VR or 0))
	AdjustHotbarFrames()
	AdjustInventoryFrames()
end

local function Clamp(low: number, high: number, num: number): number
	return math.min(high, math.max(low, num))
end

local function CheckBounds(guiObject: GuiObject, x: number, y: number): boolean
	local pos = guiObject.AbsolutePosition
	local size = guiObject.AbsoluteSize
	return (x > pos.X and x <= pos.X + size.X and y > pos.Y and y <= pos.Y + size.Y)
end

local function GetOffset(guiObject: GuiObject, point: Vector2): number
	local centerPoint = guiObject.AbsolutePosition + (guiObject.AbsoluteSize / 2)
	return (centerPoint - point).Magnitude
end

local function UnequipAllTools(): () --NOTE: HopperBin
	if Humanoid then
		Humanoid:UnequipTools()
	end
end

local function EquipNewTool(tool: Tool): () --NOTE: HopperBin
	UnequipAllTools()
	--Humanoid:EquipTool(tool) --NOTE: This would also unequip current Tool
	tool.Parent = Character --TODO: Switch back to above line after EquipTool is fixed!
end

local function IsEquipped(tool: Tool): boolean
	return tool and tool.Parent == Character --NOTE: HopperBin
end

local function MakeSlot(parent: Instance, index: number): GuiObject
	index = index or (#Slots + 1)

	-- Slot Definition --

	local slot = {}
	slot.Tool = nil
	slot.Index = index
	slot.Frame = nil

	local SlotFrame: Frame = nil
	local FakeSlotFrame = nil
	local ToolIcon: ImageLabel = nil
	local ToolName: TextLabel = nil
	local ToolChangeConn = nil
	local HighlightFrame: UIStroke = nil
	local SelectionObj = nil

	--NOTE: The following are only defined for Hotbar Slots
	local ToolTip: TextLabel = nil
	local SlotNumber: TextLabel = nil

	-- Slot Functions --

	local function UpdateSlotFading(): ()
		if VRService.VREnabled and BackpackPanel then
			local panelTransparency: number = BackpackPanel.transparency

			SlotFrame.BackgroundTransparency = panelTransparency
			SlotFrame.TextTransparency = panelTransparency
			if ToolIcon then
				ToolIcon.ImageTransparency = InventoryFrame.Visible and 0 or panelTransparency
			end
			if HighlightFrame then
				for _, child in pairs(HighlightFrame:GetChildren()) do
					child.BackgroundTransparency = panelTransparency
				end
			end

			SlotFrame.SelectionImageObject = SelectionObj
		else
			SlotFrame.SelectionImageObject = nil
			SlotFrame.BackgroundTransparency = SlotFrame.Draggable and 0 or SLOT_FADE_LOCKED
		end
		SlotFrame.BackgroundColor3 = SlotFrame.Draggable and SLOT_DRAGGABLE_COLOR or BACKGROUND_COLOR
	end

	function slot:Readjust(visualIndex: number, visualTotal: number): () --NOTE: Only used for Hotbar slots
		local centered = HotbarFrame.Size.X.Offset / 2
		local sizePlus = ICON_BUFFER + ICON_SIZE
		local midpointish = (visualTotal / 2) + 0.5
		local factor = visualIndex - midpointish
		SlotFrame.Position = UDim2.new(0, centered - (ICON_SIZE / 2) + (sizePlus * factor), 0, ICON_BUFFER)
	end

	function slot:Fill(tool: Tool)
		if not tool then
			return self:Clear()
		end

		self.Tool = tool

		local function assignToolData(): ()
			local icon = tool.TextureId
			ToolIcon.Image = icon

			if icon ~= "" then
				ToolName.Visible = false
			end

			ToolName.Text = tool.Name

			if ToolTip and tool:IsA("Tool") then --NOTE: HopperBin
				ToolTip.Text = tool.ToolTip
				ToolTip.Size = UDim2.new(0, 0, 0, TOOLTIP_HEIGHT)
				ToolTip.Position = UDim2.new(0.5, 0, 0, TOOLTIP_OFFSET)
			end
		end
		assignToolData()

		if ToolChangeConn then
			ToolChangeConn:Disconnect()
			ToolChangeConn = nil
		end

		ToolChangeConn = tool.Changed:Connect(function(property: string)
			if property == "TextureId" or property == "Name" or property == "ToolTip" then
				assignToolData()
			end
		end)

		local hotbarSlot = (self.Index <= NumberOfHotbarSlots)
		local inventoryOpen = InventoryFrame.Visible

		if (not hotbarSlot or inventoryOpen) and not UserInputService.VREnabled then
			SlotFrame.Draggable = true
		end

		self:UpdateEquipView()

		if hotbarSlot then
			FullHotbarSlots = FullHotbarSlots + 1
			-- If using a controller, determine whether or not we can enable BindCoreAction("RBXHotbarEquip", etc)
			if WholeThingEnabled then
				if FullHotbarSlots >= 1 and not GamepadActionsBound then
					-- Player added first item to a hotbar slot, enable BindCoreAction
					GamepadActionsBound = true
					ContextActionService:BindAction(
						"RBXHotbarEquip",
						changeToolFunc,
						false,
						Enum.KeyCode.ButtonL1,
						Enum.KeyCode.ButtonR1
					)
				end
			end
		end

		SlotsByTool[tool] = self
		LowestEmptySlot = FindLowestEmpty()
	end

	function slot:Clear(): ()
		if not self.Tool then
			return
		end

		if ToolChangeConn then
			ToolChangeConn:Disconnect()
			ToolChangeConn = nil
		end

		ToolIcon.Image = ""
		ToolName.Text = ""
		if ToolTip then
			ToolTip.Text = ""
			ToolTip.Visible = false
		end
		SlotFrame.Draggable = false

		self:UpdateEquipView(true) -- Show as unequipped

		if self.Index <= NumberOfHotbarSlots then
			FullHotbarSlots = FullHotbarSlots - 1
			if FullHotbarSlots < 1 then
				-- Player removed last item from hotbar; UnbindCoreAction("RBXHotbarEquip"), allowing the developer to use LB and RB.
				GamepadActionsBound = false
				ContextActionService:UnbindAction("RBXHotbarEquip")
			end
		end

		SlotsByTool[self.Tool] = nil
		self.Tool = nil
		LowestEmptySlot = FindLowestEmpty()
	end

	function slot:UpdateEquipView(unequippedOverride: boolean): ()
		if not unequippedOverride and IsEquipped(self.Tool) then -- Equipped
			lastEquippedSlot = slot
			if not HighlightFrame then
				HighlightFrame = Instance.new("UIStroke")
				HighlightFrame.Name = "Border"
				HighlightFrame.Thickness = SLOT_EQUIP_THICKNESS
				HighlightFrame.Color = SLOT_EQUIP_COLOR
				HighlightFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			end
			if LEGACY_EDGE == true then
				HighlightFrame.Parent = ToolIcon
			else
				HighlightFrame.Parent = SlotFrame
			end
		else -- In the Backpack
			if HighlightFrame then
				HighlightFrame.Parent = nil
			end
		end
		UpdateSlotFading()
	end

	function slot:IsEquipped(): boolean
		return IsEquipped(self.Tool)
	end

	function slot:Delete(): ()
		SlotFrame:Destroy() --NOTE: Also clears connections
		table.remove(Slots, self.Index)
		local newSize = #Slots

		-- Now adjust the rest (both visually and representationally)
		for i = self.Index, newSize do
			Slots[i]:SlideBack()
		end

		UpdateScrollingFrameCanvasSize()
	end

	function slot:Swap(targetSlot: any): () --NOTE: This slot (self) must not be empty!
		local myTool, otherTool = self.Tool, targetSlot.Tool
		self:Clear()
		if otherTool then -- (Target slot might be empty)
			targetSlot:Clear()
			self:Fill(otherTool)
		end
		if myTool then
			targetSlot:Fill(myTool)
		else
			targetSlot:Clear()
		end
	end

	function slot:SlideBack(): () -- For inventory slot shifting
		self.Index = self.Index - 1
		SlotFrame.Name = self.Index
		SlotFrame.LayoutOrder = self.Index
	end

	function slot:TurnNumber(on: boolean): ()
		if SlotNumber then
			SlotNumber.Visible = on
		end
	end

	function slot:SetClickability(on: boolean): () -- (Happens on open/close arrow)
		if self.Tool then
			if UserInputService.VREnabled then
				SlotFrame.Draggable = false
			else
				SlotFrame.Draggable = not on
			end
			UpdateSlotFading()
		end
	end

	function slot:CheckTerms(terms: table): number
		local hits = 0
		local function checkEm(str: string, term: table): ()
			local _, n = str:lower():gsub(term, "")
			hits = hits + n
		end
		local tool = self.Tool
		if tool then
			for term in pairs(terms) do
				checkEm(ToolName.Text, term)
				if tool:IsA("Tool") then --NOTE: HopperBin
					local toolTipText = ToolTip and ToolTip.Text or ""
					checkEm(toolTipText, term)
				end
			end
		end
		return hits
	end

	-- Slot select logic, activated by clicking or pressing hotkey
	function slot:Select(): ()
		local tool = slot.Tool
		if tool then
			if IsEquipped(tool) then --NOTE: HopperBin
				UnequipAllTools()
			elseif tool.Parent == Backpack then
				EquipNewTool(tool)
			end
		end
	end

	-- Slot Init Logic --

	SlotFrame = NewGui("TextButton", index)
	SlotFrame.BackgroundColor3 = BACKGROUND_COLOR
	SlotFrame.BorderColor3 = SLOT_BORDER_COLOR
	SlotFrame.Text = ""
	SlotFrame.AutoButtonColor = false
	SlotFrame.BorderSizePixel = 0
	SlotFrame.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
	SlotFrame.Active = true
	SlotFrame.Draggable = false
	SlotFrame.BackgroundTransparency = SLOT_FADE_LOCKED
	SlotFrame.MouseButton1Click:Connect(function(): ()
		slot:Select()
	end)
	local searchFrameCorner = Instance.new("UICorner")
	searchFrameCorner.Name = "Corner"
	searchFrameCorner.CornerRadius = SLOT_CORNER_RADIUS
	searchFrameCorner.Parent = SlotFrame
	slot.Frame = SlotFrame

	do
		local selectionObjectClipper = NewGui("Frame", "SelectionObjectClipper")
		selectionObjectClipper.Visible = false
		selectionObjectClipper.Parent = SlotFrame

		SelectionObj = NewGui("ImageLabel", "Selector")
		SelectionObj.Size = UDim2.new(1, 0, 1, 0)
		SelectionObj.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
		SelectionObj.ScaleType = Enum.ScaleType.Slice
		SelectionObj.SliceCenter = Rect.new(12, 12, 52, 52)
		SelectionObj.Parent = selectionObjectClipper
	end

	ToolIcon = NewGui("ImageLabel", "Icon")
	ToolIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	ToolIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	if LEGACY_PADDING == true then
		ToolIcon.Size = UDim2.new(1, -SLOT_EQUIP_THICKNESS * 2, 1, -SLOT_EQUIP_THICKNESS * 2)
	else
		ToolIcon.Size = UDim2.new(1, 0, 1, 0)
	end
	ToolIcon.Parent = SlotFrame

	local ToolIconCorner = Instance.new("UICorner")
	ToolIconCorner.Name = "Corner"
	if LEGACY_PADDING == true then
		ToolIconCorner.CornerRadius = SLOT_CORNER_RADIUS - UDim.new(0, SLOT_EQUIP_THICKNESS)
	else
		ToolIconCorner.CornerRadius = SLOT_CORNER_RADIUS
	end
	ToolIconCorner.Parent = ToolIcon

	ToolName = NewGui("TextLabel", "ToolName")
	ToolName.Size = UDim2.new(1, -SLOT_EQUIP_THICKNESS * 2, 1, -SLOT_EQUIP_THICKNESS * 2)
	ToolName.Position = UDim2.new(0.5, 0, 0.5, 0)
	ToolName.AnchorPoint = Vector2.new(0.5, 0.5)
	ToolName.Parent = SlotFrame

	slot.Frame.LayoutOrder = slot.Index

	if index <= NumberOfHotbarSlots then -- Hotbar-Specific Slot Stuff
		-- ToolTip stuff
		ToolTip = NewGui("TextLabel", "ToolTip")
		ToolTip.ZIndex = 2
		ToolTip.TextWrapped = false
		ToolTip.TextYAlignment = Enum.TextYAlignment.Center
		ToolTip.BackgroundColor3 = TOOLTIP_BACKGROUND_COLOR
		ToolTip.BackgroundTransparency = SLOT_FADE_LOCKED
		ToolTip.AnchorPoint = Vector2.new(0.5, 1)
		ToolTip.BorderSizePixel = 0
		ToolTip.Visible = false
		ToolTip.AutomaticSize = Enum.AutomaticSize.X
		ToolTip.Parent = SlotFrame

		local ToolTipCorner = Instance.new("UICorner")
		ToolTipCorner.Name = "Corner"
		ToolTipCorner.CornerRadius = TOOLTIP_CORNER_RADIUS
		ToolTipCorner.Parent = ToolTip

		local ToolTipPadding = Instance.new("UIPadding")
		ToolTipPadding.PaddingLeft = UDim.new(0, TOOLTIP_PADDING)
		ToolTipPadding.PaddingRight = UDim.new(0, TOOLTIP_PADDING)
		ToolTipPadding.PaddingTop = UDim.new(0, TOOLTIP_PADDING)
		ToolTipPadding.PaddingBottom = UDim.new(0, TOOLTIP_PADDING)
		ToolTipPadding.Parent = ToolTip
		SlotFrame.MouseEnter:Connect(function(): ()
			if ToolTip.Text ~= "" then
				ToolTip.Visible = true
			end
		end)
		SlotFrame.MouseLeave:Connect(function(): ()
			ToolTip.Visible = false
		end)

		function slot:MoveToInventory(): ()
			if slot.Index <= NumberOfHotbarSlots then -- From a Hotbar slot
				local tool = slot.Tool
				self:Clear() --NOTE: Order matters here
				local newSlot = MakeSlot(UIGridFrame)
				newSlot:Fill(tool)
				if IsEquipped(tool) then -- Also unequip it --NOTE: HopperBin
					UnequipAllTools()
				end
				-- Also hide the inventory slot if we're showing results right now
				if ViewingSearchResults then
					newSlot.Frame.Visible = false
					newSlot.Parent = InventoryFrame
				end
			end
		end

		-- Show label and assign hotkeys for 1-9 and 0 (zero is always last slot when > 10 total)
		if index < 10 or index == NumberOfHotbarSlots then -- NOTE: Hardcoded on purpose!
			local slotNum = (index < 10) and index or 0
			SlotNumber = NewGui("TextLabel", "Number")
			SlotNumber.Text = slotNum
			SlotNumber.Font = Enum.Font.GothamBlack
			SlotNumber.Size = UDim2.new(0.4, 0, 0.4, 0)
			SlotNumber.Visible = false
			SlotNumber.Parent = SlotFrame
			HotkeyFns[ZERO_KEY_VALUE + slotNum] = slot.Select
		end
	end

	do -- Dragging Logic
		local startPoint = SlotFrame.Position
		local lastUpTime = 0
		local startParent = nil

		SlotFrame.DragBegin:Connect(function(dragPoint: UDim2)
			Dragging[SlotFrame] = true
			startPoint = dragPoint

			SlotFrame.BorderSizePixel = 2
			InventoryIcon:lock()

			-- Raise above other slots
			SlotFrame.ZIndex = 2
			ToolIcon.ZIndex = 2
			ToolName.ZIndex = 2
			SlotFrame.Parent.ZIndex = 2
			if SlotNumber then
				SlotNumber.ZIndex = 2
			end
			-- if HighlightFrame then
			-- 	HighlightFrame.ZIndex = 2
			-- 	for _, child in pairs(HighlightFrame:GetChildren()) do
			-- 		child.ZIndex = 2
			-- 	end
			-- end

			-- Circumvent the ScrollingFrame's ClipsDescendants property
			startParent = SlotFrame.Parent
			if startParent == UIGridFrame then
				local newPosition = UDim2.new(
					0,
					SlotFrame.AbsolutePosition.X - InventoryFrame.AbsolutePosition.X,
					0,
					SlotFrame.AbsolutePosition.Y - InventoryFrame.AbsolutePosition.Y
				)
				SlotFrame.Parent = InventoryFrame
				SlotFrame.Position = newPosition

				FakeSlotFrame = NewGui("Frame", "FakeSlot")
				FakeSlotFrame.LayoutOrder = SlotFrame.LayoutOrder
				FakeSlotFrame.Size = SlotFrame.Size
				FakeSlotFrame.BackgroundTransparency = 1
				FakeSlotFrame.Parent = UIGridFrame
			end
		end)

		SlotFrame.DragStopped:Connect(function(x: number, y: number): ()
			if FakeSlotFrame then
				FakeSlotFrame:Destroy()
			end

			local now = tick()
			SlotFrame.Position = startPoint
			SlotFrame.Parent = startParent

			SlotFrame.BorderSizePixel = 0
			InventoryIcon:unlock()

			-- Restore height
			SlotFrame.ZIndex = 1
			ToolIcon.ZIndex = 1
			ToolName.ZIndex = 1
			startParent.ZIndex = 1

			if SlotNumber then
				SlotNumber.ZIndex = 1
			end
			-- if HighlightFrame then
			-- 	HighlightFrame.ZIndex = 1
			-- 	for _, child in pairs(HighlightFrame:GetChildren()) do
			-- 		child.ZIndex = 1
			-- 	end
			-- end

			Dragging[SlotFrame] = nil

			-- Make sure the tool wasn't dropped
			if not slot.Tool then
				return
			end

			-- Check where we were dropped
			if CheckBounds(InventoryFrame, x, y) then
				if slot.Index <= NumberOfHotbarSlots then
					slot:MoveToInventory()
				end
				-- Check for double clicking on an inventory slot, to move into empty hotbar slot
				if slot.Index > NumberOfHotbarSlots and now - lastUpTime < DOUBLE_CLICK_TIME then
					if LowestEmptySlot then
						local myTool = slot.Tool
						slot:Clear()
						LowestEmptySlot:Fill(myTool)
						slot:Delete()
					end
					now = 0 -- Resets the timer
				end
			elseif CheckBounds(HotbarFrame, x, y) then
				local closest = { math.huge, nil }
				for i = 1, NumberOfHotbarSlots do
					local otherSlot = Slots[i]
					local offset = GetOffset(otherSlot.Frame, Vector2.new(x, y))
					if offset < closest[1] then
						closest = { offset, otherSlot }
					end
				end
				local closestSlot = closest[2]
				if closestSlot ~= slot then
					slot:Swap(closestSlot)
					if slot.Index > NumberOfHotbarSlots then
						local tool = slot.Tool
						if not tool then -- Clean up after ourselves if we're an inventory slot that's now empty
							slot:Delete()
						else -- Moved inventory slot to hotbar slot, and gained a tool that needs to be unequipped
							if IsEquipped(tool) then --NOTE: HopperBin
								UnequipAllTools()
							end
							-- Also hide the inventory slot if we're showing results right now
							if ViewingSearchResults then
								slot.Frame.Visible = false
								slot.Frame.Parent = InventoryFrame
							end
						end
					end
				end
			else
				-- local tool = slot.Tool
				-- if tool.CanBeDropped then --TODO: HopperBins
				-- tool.Parent = workspace
				-- --TODO: Move away from character
				-- end
				if slot.Index <= NumberOfHotbarSlots then
					slot:MoveToInventory() --NOTE: Temporary
				end
			end

			lastUpTime = now
		end)
	end

	-- All ready!
	SlotFrame.Parent = parent
	Slots[index] = slot

	if index > NumberOfHotbarSlots then
		UpdateScrollingFrameCanvasSize()
		-- Scroll to new inventory slot, if we're open and not viewing search results
		if InventoryFrame.Visible and not ViewingSearchResults then
			local offset = ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteSize.Y
			ScrollingFrame.CanvasPosition = Vector2.new(0, math.max(0, offset))
		end
	end

	return slot
end

local function OnChildAdded(child: Instance): () -- To Character or Backpack
	if not child:IsA("Tool") then --NOTE: HopperBin
		if child:IsA("Humanoid") and child.Parent == Character then
			Humanoid = child
		end
		return
	end
	local tool = child

	if tool.Parent == Character then
		ShowVRBackpackPopup()
	end

	--TODO: Optimize / refactor / do something else
	if not StarterToolFound and tool.Parent == Character and not SlotsByTool[tool] then
		local starterGear = Player:FindFirstChild("StarterGear")
		if starterGear then
			if starterGear:FindFirstChild(tool.Name) then
				StarterToolFound = true
				local slot = LowestEmptySlot or MakeSlot(UIGridFrame)
				for i = slot.Index, 1, -1 do
					local curr = Slots[i] -- An empty slot, because above
					local pIndex = i - 1
					if pIndex > 0 then
						local prev = Slots[pIndex] -- Guaranteed to be full, because above
						prev:Swap(curr)
					else
						curr:Fill(tool)
					end
				end
				-- Have to manually unequip a possibly equipped tool
				for _, children in pairs(Character:GetChildren()) do
					if children:IsA("Tool") and children ~= tool then
						children.Parent = Backpack
					end
				end
				AdjustHotbarFrames()
				return -- We're done here
			end
		end
	end

	-- The tool is either moving or new
	local slot = SlotsByTool[tool]
	if slot then
		slot:UpdateEquipView()
	else -- New! Put into lowest hotbar slot or new inventory slot
		slot = LowestEmptySlot or MakeSlot(UIGridFrame)
		slot:Fill(tool)
		if slot.Index <= NumberOfHotbarSlots and not InventoryFrame.Visible then
			AdjustHotbarFrames()
		end
	end
end

local function OnChildRemoved(child: Instance): () -- From Character or Backpack
	if not child:IsA("Tool") then --NOTE: HopperBin
		return
	end
	local tool = child

	ShowVRBackpackPopup()

	-- Ignore this event if we're just moving between the two
	local newParent = tool.Parent
	if newParent == Character or newParent == Backpack then
		return
	end

	local slot = SlotsByTool[tool]
	if slot then
		slot:Clear()
		if slot.Index > NumberOfHotbarSlots then -- Inventory slot
			slot:Delete()
		elseif not InventoryFrame.Visible then
			AdjustHotbarFrames()
		end
	end
end

local function OnCharacterAdded(character: Model): ()
	-- First, clean up any old slots
	for i = #Slots, 1, -1 do
		local slot = Slots[i]
		if slot.Tool then
			slot:Clear()
		end
		if i > NumberOfHotbarSlots then
			slot:Delete()
		end
	end

	-- And any old Connections
	for _, conn in pairs(CharConns) do
		conn:Disconnect()
	end
	CharConns = {}

	-- Hook up the new character
	Character = character
	table.insert(CharConns, character.ChildRemoved:Connect(OnChildRemoved))
	table.insert(CharConns, character.ChildAdded:Connect(OnChildAdded))
	for _, child in pairs(character:GetChildren()) do
		OnChildAdded(child)
	end
	--NOTE: Humanoid is set inside OnChildAdded

	-- And the new backpack, when it gets here
	Backpack = Player:WaitForChild("Backpack")
	table.insert(CharConns, Backpack.ChildRemoved:Connect(OnChildRemoved))
	table.insert(CharConns, Backpack.ChildAdded:Connect(OnChildAdded))
	for _, child in pairs(Backpack:GetChildren()) do
		OnChildAdded(child)
	end

	AdjustHotbarFrames()
end

local function OnInputBegan(input: InputObject, isProcessed: boolean): ()
	-- Pass through keyboard hotkeys when not typing into a TextBox and not disabled (except for the Drop key)
	if
		input.UserInputType == Enum.UserInputType.Keyboard
		and not TextBoxFocused
		and (WholeThingEnabled or input.KeyCode.Value == DROP_HOTKEY_VALUE)
	then
		local hotkeyBehavior = HotkeyFns[input.KeyCode.Value]
		if hotkeyBehavior then
			hotkeyBehavior(isProcessed)
		end
	end

	local inputType = input.UserInputType
	if not isProcessed then
		if inputType == Enum.UserInputType.MouseButton1 or inputType == Enum.UserInputType.Touch then
			if InventoryFrame.Visible then
				InventoryIcon:deselect()
			end
		end
	end
end

local function OnUISChanged(property: string): ()
	if property == "KeyboardEnabled" or property == "VREnabled" then
		local on = UserInputService.KeyboardEnabled and not UserInputService.VREnabled
		for i = 1, NumberOfHotbarSlots do
			Slots[i]:TurnNumber(on)
		end
	end
end

local lastChangeToolInputObject = nil
local lastChangeToolInputTime = nil
local maxEquipDeltaTime = 0.06
local noOpFunc = function() end
-- local selectDirection = Vector2.new(0, 0)
-- local hotbarVisible = false

function unbindAllGamepadEquipActions(): ()
	ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
	ContextActionService:UnbindAction("RBXCloseInventory")
end

-- local function setHotbarVisibility(visible: boolean, isInventoryScreen: boolean): ()
-- 	for i = 1, NumberOfHotbarSlots do
-- 		local hotbarSlot = Slots[i]
-- 		if hotbarSlot and hotbarSlot.Frame and (isInventoryScreen or hotbarSlot.Tool) then
-- 			hotbarSlot.Frame.Visible = visible
-- 		end
-- 	end
-- end

-- local function getInputDirection(inputObject: InputObject): Vector2
-- 	local buttonModifier = 1
-- 	if inputObject.UserInputState == Enum.UserInputState.End then
-- 		buttonModifier = -1
-- 	end

-- 	if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then
-- 		local Magnitude = inputObject.Position.Magnitude

-- 		if Magnitude > 0.98 then
-- 			local normalizedVector =
-- 				Vector2.new(inputObject.Position.X / Magnitude, -inputObject.Position.Y / Magnitude)
-- 			selectDirection = normalizedVector
-- 		else
-- 			selectDirection = Vector2.new(0, 0)
-- 		end
-- 	elseif inputObject.KeyCode == Enum.KeyCode.DPadLeft then
-- 		selectDirection = Vector2.new(selectDirection.X - 1 * buttonModifier, selectDirection.Y)
-- 	elseif inputObject.KeyCode == Enum.KeyCode.DPadRight then
-- 		selectDirection = Vector2.new(selectDirection.X + 1 * buttonModifier, selectDirection.Y)
-- 	elseif inputObject.KeyCode == Enum.KeyCode.DPadUp then
-- 		selectDirection = Vector2.new(selectDirection.X, selectDirection.Y - 1 * buttonModifier)
-- 	elseif inputObject.KeyCode == Enum.KeyCode.DPadDown then
-- 		selectDirection = Vector2.new(selectDirection.X, selectDirection.Y + 1 * buttonModifier)
-- 	else
-- 		selectDirection = Vector2.new(0, 0)
-- 	end

-- 	return selectDirection
-- end

-- local selectToolExperiment = function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject): ()
-- 	local inputDirection = getInputDirection(inputObject)

-- 	if inputDirection == Vector2.new(0, 0) then
-- 		return
-- 	end

-- 	local angle = math.atan2(inputDirection.Y, inputDirection.X) - math.atan2(-1, 0)
-- 	if angle < 0 then
-- 		angle = angle + (math.pi * 2)
-- 	end

-- 	local quarterPi = (math.pi * 0.25)

-- 	local index = (angle / quarterPi) + 1
-- 	index = math.floor(index + 0.5) -- round index to whole number
-- 	if index > NumberOfHotbarSlots then
-- 		index = 1
-- 	end

-- 	if index > 0 then
-- 		local selectedSlot = Slots[index]
-- 		if selectedSlot and selectedSlot.Tool and not selectedSlot:IsEquipped() then
-- 			selectedSlot:Select()
-- 		end
-- 	else
-- 		UnequipAllTools()
-- 	end
-- end

function changeToolFunc(inputState: Enum.UserInputState, inputObject: InputObject): ()
	if inputState ~= Enum.UserInputState.Begin then
		return
	end

	if lastChangeToolInputObject then
		if
			(
				lastChangeToolInputObject.KeyCode == Enum.KeyCode.ButtonR1
				and inputObject.KeyCode == Enum.KeyCode.ButtonL1
			)
			or (
				lastChangeToolInputObject.KeyCode == Enum.KeyCode.ButtonL1
				and inputObject.KeyCode == Enum.KeyCode.ButtonR1
			)
		then
			if (tick() - lastChangeToolInputTime) <= maxEquipDeltaTime then
				UnequipAllTools()
				lastChangeToolInputObject = inputObject
				lastChangeToolInputTime = tick()
				return
			end
		end
	end

	lastChangeToolInputObject = inputObject
	lastChangeToolInputTime = tick()

	delay(maxEquipDeltaTime, function(): ()
		if lastChangeToolInputObject ~= inputObject then
			return
		end

		local moveDirection = 0
		if inputObject.KeyCode == Enum.KeyCode.ButtonL1 then
			moveDirection = -1
		else
			moveDirection = 1
		end

		for i = 1, NumberOfHotbarSlots do
			local hotbarSlot = Slots[i]
			if hotbarSlot:IsEquipped() then
				local newSlotPosition = moveDirection + i
				local hitEdge = false
				if newSlotPosition > NumberOfHotbarSlots then
					newSlotPosition = 1
					hitEdge = true
				elseif newSlotPosition < 1 then
					newSlotPosition = NumberOfHotbarSlots
					hitEdge = true
				end

				local origNewSlotPos = newSlotPosition
				while not Slots[newSlotPosition].Tool do
					newSlotPosition = newSlotPosition + moveDirection
					if newSlotPosition == origNewSlotPos then
						return
					end

					if newSlotPosition > NumberOfHotbarSlots then
						newSlotPosition = 1
						hitEdge = true
					elseif newSlotPosition < 1 then
						newSlotPosition = NumberOfHotbarSlots
						hitEdge = true
					end
				end

				if hitEdge then
					UnequipAllTools()
					lastEquippedSlot = nil
				else
					Slots[newSlotPosition]:Select()
				end
				return
			end
		end

		if lastEquippedSlot and lastEquippedSlot.Tool then
			lastEquippedSlot:Select()
			return
		end

		local startIndex = moveDirection == -1 and NumberOfHotbarSlots or 1
		local endIndex = moveDirection == -1 and 1 or NumberOfHotbarSlots
		for i = startIndex, endIndex, moveDirection do
			if Slots[i].Tool then
				Slots[i]:Select()
				return
			end
		end
	end)
end

function getGamepadSwapSlot(): any
	for i = 1, #Slots do
		if Slots[i].Frame.BorderSizePixel > 0 then
			return Slots[i]
		end
	end
end

-- function changeSlot(slot: any): ()
-- 	local swapInVr = not VRService.VREnabled or InventoryFrame.Visible

-- 	if slot.Frame == GuiService.SelectedObject and swapInVr then
-- 		local currentlySelectedSlot: any = getGamepadSwapSlot()

-- 		if currentlySelectedSlot then
-- 			currentlySelectedSlot.Frame.BorderSizePixel = 0
-- 			if currentlySelectedSlot ~= slot then
-- 				slot:Swap(currentlySelectedSlot)
-- 				VRInventorySelector.SelectionImageObject.Visible = false

-- 				if slot.Index > NumberOfHotbarSlots and not slot.Tool then
-- 					if GuiService.SelectedObject == slot.Frame then
-- 						GuiService.SelectedObject = currentlySelectedSlot.Frame
-- 					end
-- 					slot:Delete()
-- 				end

-- 				if currentlySelectedSlot.Index > NumberOfHotbarSlots and not currentlySelectedSlot.Tool then
-- 					if GuiService.SelectedObject == currentlySelectedSlot.Frame then
-- 						GuiService.SelectedObject = slot.Frame
-- 					end
-- 					currentlySelectedSlot:Delete()
-- 				end
-- 			end
-- 		else
-- 			local startSize = slot.Frame.Size
-- 			local startPosition = slot.Frame.Position
-- 			slot.Frame:TweenSizeAndPosition(
-- 				startSize + UDim2.new(0, 10, 0, 10),
-- 				startPosition - UDim2.new(0, 5, 0, 5),
-- 				Enum.EasingDirection.Out,
-- 				Enum.EasingStyle.Quad,
-- 				0.1,
-- 				true,
-- 				function(): ()
-- 					slot.Frame:TweenSizeAndPosition(
-- 						startSize,
-- 						startPosition,
-- 						Enum.EasingDirection.In,
-- 						Enum.EasingStyle.Quad,
-- 						0.1,
-- 						true
-- 					)
-- 				end
-- 			)
-- 			slot.Frame.BorderSizePixel = 3
-- 			VRInventorySelector.SelectionImageObject.Visible = true
-- 		end
-- 	else
-- 		slot:Select()
-- 		VRInventorySelector.SelectionImageObject.Visible = false
-- 	end
-- end

function vrMoveSlotToInventory(): ()
	if not VRService.VREnabled then
		return
	end

	local currentlySelectedSlot = getGamepadSwapSlot()
	if currentlySelectedSlot and currentlySelectedSlot.Tool then
		currentlySelectedSlot.Frame.BorderSizePixel = 0
		currentlySelectedSlot:MoveToInventory()
		VRInventorySelector.SelectionImageObject.Visible = false
	end
end

function enableGamepadInventoryControl(): ()
	local goBackOneLevel = function(inputState)
		if inputState ~= Enum.UserInputState.Begin then
			return
		end

		local selectedSlot = getGamepadSwapSlot()
		if selectedSlot then
			selectedSlot.Frame.BorderSizePixel = 0
			return
		elseif InventoryFrame.Visible then
			InventoryIcon:deselect()
		end
	end

	ContextActionService:BindAction("RBXBackpackHasGamepadFocus", noOpFunc, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction(
		"RBXCloseInventory",
		goBackOneLevel,
		false,
		Enum.KeyCode.ButtonB,
		Enum.KeyCode.ButtonStart
	)

	-- Gaze select will automatically select the object for us!
	if not UseGazeSelection() then
		GuiService.SelectedObject = HotbarFrame:FindFirstChild("1")
	end
end

function disableGamepadInventoryControl(): ()
	unbindAllGamepadEquipActions()

	for i = 1, NumberOfHotbarSlots do
		local hotbarSlot = Slots[i]
		if hotbarSlot and hotbarSlot.Frame then
			hotbarSlot.Frame.BorderSizePixel = 0
		end
	end

	if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(MainFrame) then
		GuiService.SelectedObject = nil
	end
end

local function bindBackpackHotbarAction(): ()
	if WholeThingEnabled and not GamepadActionsBound then
		GamepadActionsBound = true
		ContextActionService:BindAction(
			"RBXHotbarEquip",
			changeToolFunc,
			false,
			Enum.KeyCode.ButtonL1,
			Enum.KeyCode.ButtonR1
		)
	end
end

local function unbindBackpackHotbarAction(): ()
	disableGamepadInventoryControl()
	GamepadActionsBound = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected(): ()
	GamepadEnabled = false
	disableGamepadInventoryControl()
end

function gamepadConnected(): ()
	GamepadEnabled = true
	GuiService:AddSelectionParent("RBXBackpackSelection", MainFrame)

	if FullHotbarSlots >= 1 then
		bindBackpackHotbarAction()
	end

	if InventoryFrame.Visible then
		enableGamepadInventoryControl()
	end
end

local function OnIconChanged(enabled: boolean): ()
	-- Check for enabling/disabling the whole thing
	enabled = enabled and StarterGui:GetCore("TopbarEnabled")
	InventoryIcon:setEnabled(enabled and not GuiService.MenuIsOpen)
	WholeThingEnabled = enabled
	MainFrame.Visible = enabled

	-- Eat/Release hotkeys (Doesn't affect UserInputService)
	-- for _, keyString in pairs(HotkeyStrings) do
	-- 	if enabled then
	-- 		GuiService:AddKey(keyString)
	-- 	else
	-- 		GuiService:RemoveKey(keyString)
	-- 	end
	-- end

	if enabled then
		if FullHotbarSlots >= 1 then
			bindBackpackHotbarAction()
		end
	else
		unbindBackpackHotbarAction()
	end
end

local function MakeVRRoundButton(name: string, image: string): (GuiObject, GuiObject, GuiObject)
	local newButton = NewGui("ImageButton", name)
	newButton.Size = UDim2.new(0, 40, 0, 40)
	newButton.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"

	local buttonIcon = NewGui("ImageLabel", "Icon")
	buttonIcon.Size = UDim2.new(0.5, 0, 0.5, 0)
	buttonIcon.Position = UDim2.new(0.25, 0, 0.25, 0)
	buttonIcon.Image = image
	buttonIcon.Parent = newButton

	local buttonSelectionObject = NewGui("ImageLabel", "Selection")
	buttonSelectionObject.Size = UDim2.new(0.9, 0, 0.9, 0)
	buttonSelectionObject.Position = UDim2.new(0.05, 0, 0.05, 0)
	buttonSelectionObject.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	newButton.SelectionImageObject = buttonSelectionObject

	return newButton, buttonIcon, buttonSelectionObject
end

-- Make the main frame, which (mostly) covers the screen
MainFrame = NewGui("Frame", "Backpack")
MainFrame.Visible = false
MainFrame.Parent = BackpackGui

-- Make the HotbarFrame, which holds only the Hotbar Slots
HotbarFrame = NewGui("Frame", "Hotbar")
HotbarFrame.Parent = MainFrame

-- Make all the Hotbar Slots
for i = 1, NumberOfHotbarSlots do
	local slot = MakeSlot(HotbarFrame, i)
	slot.Frame.Visible = false

	if not LowestEmptySlot then
		LowestEmptySlot = slot
	end
end

InventoryIcon.selected:Connect(function(): ()
	if not GuiService.MenuIsOpen then
		BackpackScript.OpenClose()
	end
end)
InventoryIcon.deselected:Connect(function(): ()
	if InventoryFrame.Visible then
		BackpackScript.OpenClose()
	end
end)

local LeftBumperButton = NewGui("ImageLabel", "LeftBumper")
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2)

local RightBumperButton = NewGui("ImageLabel", "RightBumper")
RightBumperButton.Size = UDim2.new(0, 40, 0, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2)

-- Make the Inventory, which holds the ScrollingFrame, the header, and the search box
InventoryFrame = NewGui("Frame", "Inventory")
InventoryFrame.BackgroundTransparency = BACKGROUND_FADE
InventoryFrame.BackgroundColor3 = BACKGROUND_COLOR
InventoryFrame.Active = true
InventoryFrame.Visible = false
InventoryFrame.Parent = MainFrame

-- Add corners to the InventoryFrame
local corner = Instance.new("UICorner")
corner.Name = "Corner"
corner.CornerRadius = BACKGROUND_CORNER_RADIUS
corner.Parent = InventoryFrame

VRInventorySelector = NewGui("TextButton", "VRInventorySelector")
VRInventorySelector.Position = UDim2.new(0, 0, 0, 0)
VRInventorySelector.Size = UDim2.new(1, 0, 1, 0)
VRInventorySelector.BackgroundTransparency = 1
VRInventorySelector.Text = ""
VRInventorySelector.Parent = InventoryFrame

local selectorImage = NewGui("ImageLabel", "Selector")
selectorImage.Size = UDim2.new(1, 0, 1, 0)
selectorImage.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
selectorImage.ScaleType = Enum.ScaleType.Slice
selectorImage.SliceCenter = Rect.new(12, 12, 52, 52)
selectorImage.Visible = false
VRInventorySelector.SelectionImageObject = selectorImage

VRInventorySelector.MouseButton1Click:Connect(function(): ()
	vrMoveSlotToInventory()
end)

-- Make the ScrollingFrame, which holds the rest of the Slots (however many)
ScrollingFrame = NewGui("ScrollingFrame", "ScrollingFrame")
ScrollingFrame.Selectable = false
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.new(1, 1, 1)
ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = InventoryFrame

UIGridFrame = NewGui("Frame", "UIGridFrame")
UIGridFrame.Selectable = false
UIGridFrame.Size = UDim2.new(1, -(ICON_BUFFER * 2), 1, 0)
UIGridFrame.Position = UDim2.new(0, ICON_BUFFER, 0, 0)
UIGridFrame.Parent = ScrollingFrame

UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
UIGridLayout.CellPadding = UDim2.new(0, ICON_BUFFER, 0, ICON_BUFFER)
UIGridLayout.Parent = UIGridFrame

ScrollUpInventoryButton = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
ScrollUpInventoryButton.Size = UDim2.new(0, 34, 0, 34)
ScrollUpInventoryButton.Position =
	UDim2.new(0.5, -ScrollUpInventoryButton.Size.X.Offset / 2, 0, INVENTORY_HEADER_SIZE + 3)
ScrollUpInventoryButton.Icon.Position = ScrollUpInventoryButton.Icon.Position - UDim2.new(0, 0, 0, 2)
ScrollUpInventoryButton.MouseButton1Click:Connect(function(): ()
	ScrollingFrame.CanvasPosition = Vector2.new(
		ScrollingFrame.CanvasPosition.X,
		Clamp(
			0,
			ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y,
			ScrollingFrame.CanvasPosition.Y - (ICON_BUFFER + ICON_SIZE)
		)
	)
end)

ScrollDownInventoryButton = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
ScrollDownInventoryButton.Rotation = 180
ScrollDownInventoryButton.Icon.Position = ScrollDownInventoryButton.Icon.Position - UDim2.new(0, 0, 0, 2)
ScrollDownInventoryButton.Size = UDim2.new(0, 34, 0, 34)
ScrollDownInventoryButton.Position =
	UDim2.new(0.5, -ScrollDownInventoryButton.Size.X.Offset / 2, 1, -ScrollDownInventoryButton.Size.Y.Offset - 3)
ScrollDownInventoryButton.MouseButton1Click:Connect(function(): ()
	ScrollingFrame.CanvasPosition = Vector2.new(
		ScrollingFrame.CanvasPosition.X,
		Clamp(
			0,
			ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y,
			ScrollingFrame.CanvasPosition.Y + (ICON_BUFFER + ICON_SIZE)
		)
	)
end)

ScrollingFrame.Changed:Connect(function(prop: string)
	if prop == "AbsoluteWindowSize" or prop == "CanvasPosition" or prop == "CanvasSize" then
		local canScrollUp = ScrollingFrame.CanvasPosition.Y ~= 0
		local canScrollDown = ScrollingFrame.CanvasPosition.Y
			< ScrollingFrame.CanvasSize.Y.Offset - ScrollingFrame.AbsoluteWindowSize.Y

		ScrollUpInventoryButton.Visible = canScrollUp
		ScrollDownInventoryButton.Visible = canScrollDown
	end
end)

-- Position the frames and sizes for the Backpack GUI elements
UpdateBackpackLayout()

--Make the gamepad hint frame
local gamepadHintsFrame = Instance.new("Frame")
gamepadHintsFrame.Name = "GamepadHintsFrame"
gamepadHintsFrame.Size = UDim2.new(0, HotbarFrame.Size.X.Offset, 0, (IsTenFootInterface and 95 or 60))
gamepadHintsFrame.BackgroundTransparency = 1
gamepadHintsFrame.Visible = false
gamepadHintsFrame.Parent = MainFrame

local function addGamepadHint(hintImageSmall: string, hintImageLarge: string, hintTextString: string): ()
	local hintFrame = Instance.new("Frame")
	hintFrame.Name = "HintFrame"
	hintFrame.Size = UDim2.new(1, 0, 1, -5)
	hintFrame.Position = UDim2.new(0, 0, 0, 0)
	hintFrame.BackgroundTransparency = 1
	hintFrame.Parent = gamepadHintsFrame

	local hintImage = Instance.new("ImageLabel")
	hintImage.Name = "HintImage"
	hintImage.Size = (IsTenFootInterface and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60))
	hintImage.BackgroundTransparency = 1
	hintImage.Image = (IsTenFootInterface and hintImageLarge or hintImageSmall)
	hintImage.Parent = hintFrame

	local hintText = Instance.new("TextLabel")
	hintText.Name = "HintText"
	hintText.Position = UDim2.new(0.1, (IsTenFootInterface and 100 or 70), 0.1, 0)
	hintText.Size = UDim2.new(1, -(IsTenFootInterface and 100 or 70), 1, 0)
	hintText.Font = Enum.Font.SourceSansBold
	hintText.FontSize = (IsTenFootInterface and Enum.FontSize.Size36 or Enum.FontSize.Size24)
	hintText.BackgroundTransparency = 1
	hintText.Text = hintTextString
	hintText.TextColor3 = Color3.new(1, 1, 1)
	hintText.TextXAlignment = Enum.TextXAlignment.Left
	hintText.TextWrapped = true
	hintText.Parent = hintFrame

	local textSizeConstraint = Instance.new("UITextSizeConstraint")
	textSizeConstraint.MaxTextSize = hintText.TextSize
	textSizeConstraint.Parent = hintText
end

local function resizeGamepadHintsFrame(): ()
	gamepadHintsFrame.Size =
		UDim2.new(HotbarFrame.Size.X.Scale, HotbarFrame.Size.X.Offset, 0, (IsTenFootInterface and 95 or 60))
	gamepadHintsFrame.Position = UDim2.new(
		HotbarFrame.Position.X.Scale,
		HotbarFrame.Position.X.Offset,
		InventoryFrame.Position.Y.Scale,
		InventoryFrame.Position.Y.Offset - gamepadHintsFrame.Size.Y.Offset
	)

	local spaceTaken = 0

	local gamepadHints = gamepadHintsFrame:GetChildren()
	--First get the total space taken by all the hints
	for i = 1, #gamepadHints do
		gamepadHints[i].Size = UDim2.new(1, 0, 1, -5)
		gamepadHints[i].Position = UDim2.new(0, 0, 0, 0)
		spaceTaken = spaceTaken + (gamepadHints[i].HintText.Position.X.Offset + gamepadHints[i].HintText.TextBounds.X)
	end

	--The space between all the frames should be equal
	local spaceBetweenElements = (gamepadHintsFrame.AbsoluteSize.X - spaceTaken) / (#gamepadHints - 1)
	for i = 1, #gamepadHints do
		gamepadHints[i].Position = (
			i == 1 and UDim2.new(0, 0, 0, 0)
			or UDim2.new(
				0,
				gamepadHints[i - 1].Position.X.Offset + gamepadHints[i - 1].Size.X.Offset + spaceBetweenElements,
				0,
				0
			)
		)
		gamepadHints[i].Size =
			UDim2.new(0, (gamepadHints[i].HintText.Position.X.Offset + gamepadHints[i].HintText.TextBounds.X), 1, -5)
	end
end

if GetFFlagUseDesignSystemGamepadIcons then
	addGamepadHint(
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonX@2x.png",
		"Remove From Hotbar"
	)
	addGamepadHint(
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png",
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonA@2x.png",
		"Select/Swap"
	)
	addGamepadHint(
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png",
		"rbxasset://textures/ui/Controls/DesignSystem/ButtonB@2x.png",
		"Close Backpack"
	)
else
	addGamepadHint(
		"rbxasset://textures/ui/Settings/Help/XButtonDark.png",
		"rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png",
		"Remove From Hotbar"
	)
	addGamepadHint(
		"rbxasset://textures/ui/Settings/Help/AButtonDark.png",
		"rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png",
		"Select/Swap"
	)
	addGamepadHint(
		"rbxasset://textures/ui/Settings/Help/BButtonDark.png",
		"rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png",
		"Close Backpack"
	)
end

do -- Search stuff
	local searchFrame = NewGui("Frame", "Search")
	searchFrame.BackgroundColor3 = SEARCH_BACKGROUND_COLOR
	searchFrame.BackgroundTransparency = SEARCH_BACKGROUND_FADE
	searchFrame.Size = UDim2.new(0, SEARCH_WIDTH - (SEARCH_BUFFER * 2), 0, INVENTORY_HEADER_SIZE - (SEARCH_BUFFER * 2))
	searchFrame.Position = UDim2.new(1, -searchFrame.Size.X.Offset - SEARCH_BUFFER, 0, SEARCH_BUFFER)
	searchFrame.Parent = InventoryFrame

	local searchFrameCorner = Instance.new("UICorner")
	searchFrameCorner.Name = "Corner"
	searchFrameCorner.CornerRadius = SEARCH_CORNER_RADIUS
	searchFrameCorner.Parent = searchFrame

	local searchFrameBorder = Instance.new("UIStroke")
	searchFrameBorder.Name = "Border"
	searchFrameBorder.Color = SEARCH_BORDER_COLOR
	searchFrameBorder.Thickness = SEARCH_BORDER_THICKNESS
	searchFrameBorder.Transparency = SEARCH_BORDER_FADE
	searchFrameBorder.Parent = searchFrame

	local searchBox = NewGui("TextBox", "TextBox")
	searchBox.PlaceholderText = SEARCH_PLACEHOLDER
	-- searchBox.PlaceholderColor3 = SEARCH_PLACEHOLDER_COLOR
	searchBox.TextColor3 = SEARCH_TEXT_COLOR
	searchBox.TextTransparency = TEXT_FADE
	searchBox.TextStrokeColor3 = SEARCH_TEXT_STROKE_COLOR
	searchBox.ClearTextOnFocus = false
	searchBox.TextTruncate = Enum.TextTruncate.AtEnd
	searchBox.FontSize = Enum.FontSize.Size14
	searchBox.TextXAlignment = Enum.TextXAlignment.Left
	searchBox.TextYAlignment = Enum.TextYAlignment.Center
	searchBox.Size = UDim2.new(
		0,
		(SEARCH_WIDTH - (SEARCH_BUFFER * 2)) - (SEARCH_TEXT_OFFSET * 2) - 20,
		0,
		INVENTORY_HEADER_SIZE - (SEARCH_BUFFER * 2) - (SEARCH_TEXT_OFFSET * 2)
	)
	searchBox.AnchorPoint = Vector2.new(0, 0.5)
	searchBox.Position = UDim2.new(0, SEARCH_TEXT_OFFSET, 0.5, 0)
	searchBox.ZIndex = 2
	searchBox.Parent = searchFrame

	local xButton = NewGui("TextButton", "X")
	xButton.Text = ""
	xButton.Size = UDim2.new(0, 30, 0, 30)
	xButton.Position = UDim2.new(1, -xButton.Size.X.Offset, 0.5, -xButton.Size.Y.Offset / 2)
	xButton.ZIndex = 4
	xButton.Visible = false
	xButton.BackgroundTransparency = 1
	xButton.Parent = searchFrame

	local xImage = NewGui("ImageButton", "X")
	xImage.Image = SEARCH_ICON_X
	xImage.BackgroundTransparency = 1
	xImage.Size = UDim2.new(
		0,
		searchFrame.Size.Y.Offset - (SEARCH_BUFFER * 4),
		0,
		searchFrame.Size.Y.Offset - (SEARCH_BUFFER * 4)
	)
	xImage.AnchorPoint = Vector2.new(0.5, 0.5)
	xImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	xImage.ZIndex = 1
	xImage.BorderSizePixel = 0
	xImage.Parent = xButton

	local function search(): ()
		local terms = {}
		for word in searchBox.Text:gmatch("%S+") do
			terms[word:lower()] = true
		end

		local hitTable = {}
		for i = NumberOfHotbarSlots + 1, #Slots do -- Only search inventory slots
			local slot = Slots[i]
			local hits = slot:CheckTerms(terms)
			table.insert(hitTable, { slot, hits })
			slot.Frame.Visible = false
			slot.Frame.Parent = InventoryFrame
		end

		table.sort(hitTable, function(left, right)
			return left[2] > right[2]
		end)
		ViewingSearchResults = true

		local hitCount = 0
		for _, data in ipairs(hitTable) do
			local slot, hits = data[1], data[2]
			if hits > 0 then
				slot.Frame.Visible = true
				slot.Frame.Parent = UIGridFrame
				slot.Frame.LayoutOrder = NumberOfHotbarSlots + hitCount
				hitCount = hitCount + 1
			end
		end

		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
		UpdateScrollingFrameCanvasSize()

		xButton.ZIndex = 3
	end

	local function clearResults(): ()
		if xButton.ZIndex > 0 then
			ViewingSearchResults = false
			for i = NumberOfHotbarSlots + 1, #Slots do
				local slot = Slots[i]
				slot.Frame.LayoutOrder = slot.Index
				slot.Frame.Parent = UIGridFrame
				slot.Frame.Visible = true
			end
			xButton.ZIndex = 0
		end
		UpdateScrollingFrameCanvasSize()
	end

	local function reset(): ()
		clearResults()
		searchBox.Text = ""
	end

	local function onChanged(property: string): ()
		if property == "Text" then
			local text = searchBox.Text
			if text == "" then
				searchBox.TextTransparency = TEXT_FADE
				clearResults()
			elseif text ~= SEARCH_TEXT then
				searchBox.TextTransparency = 0
				search()
			end
			xButton.Visible = text ~= "" and text ~= SEARCH_TEXT
		end
	end

	local function focusLost(enterPressed: boolean): ()
		if enterPressed then
			--TODO: Could optimize
			search()
		end
	end

	xButton.MouseButton1Click:Connect(reset)
	searchBox.Changed:Connect(onChanged)
	searchBox.FocusLost:Connect(focusLost)

	BackpackScript.StateChanged.Event:Connect(function(isNowOpen: boolean): ()
		InventoryIcon:getInstance("iconButton").Modal = isNowOpen -- Allows free mouse movement even in first person

		if not isNowOpen then
			reset()
		end
	end)

	HotkeyFns[Enum.KeyCode.Escape.Value] = function(isProcessed: any): ()
		if isProcessed then -- Pressed from within a TextBox
			reset()
		elseif InventoryFrame.Visible then
			InventoryIcon:deselect()
		end
	end

	local function detectGamepad(lastInputType: Enum.UserInputType): ()
		if lastInputType == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
			searchFrame.Visible = false
		else
			searchFrame.Visible = true
		end
	end
	UserInputService.LastInputTypeChanged:Connect(detectGamepad)
end

local menuClosed = false

GuiService.MenuOpened:Connect(function(): ()
	BackpackGui.Enabled = false
	if InventoryFrame.Visible then
		InventoryIcon:deselect()
		menuClosed = true
	end
end)

GuiService.MenuClosed:Connect(function(): ()
	BackpackGui.Enabled = true
	if menuClosed then
		InventoryIcon:select()
		menuClosed = false
	end
end)

do -- Make the Inventory expand/collapse arrow (unless TopBar)
	local removeHotBarSlot = function(state: Enum.UserInputState): ()
		if state ~= Enum.UserInputState.Begin then
			return
		end
		if not GuiService.SelectedObject then
			return
		end

		for i = 1, NumberOfHotbarSlots do
			if Slots[i].Frame == GuiService.SelectedObject and Slots[i].Tool then
				Slots[i]:MoveToInventory()
				return
			end
		end
	end

	local function openClose(): ()
		if not next(Dragging) then -- Only continue if nothing is being dragged
			InventoryFrame.Visible = not InventoryFrame.Visible
			local nowOpen = InventoryFrame.Visible
			AdjustHotbarFrames()
			HotbarFrame.Active = not HotbarFrame.Active
			for i = 1, NumberOfHotbarSlots do
				Slots[i]:SetClickability(not nowOpen)
			end
		end

		if InventoryFrame.Visible then
			if GamepadEnabled then
				if GAMEPAD_INPUT_TYPES[UserInputService:GetLastInputType()] then
					resizeGamepadHintsFrame()
					gamepadHintsFrame.Visible = not UserInputService.VREnabled
				end
				enableGamepadInventoryControl()
			end
			if BackpackPanel and VRService.VREnabled then
				BackpackPanel:SetVisible(true)
				BackpackPanel:RequestPositionUpdate()
			end
		else
			if GamepadEnabled then
				gamepadHintsFrame.Visible = false
			end
			disableGamepadInventoryControl()
		end

		if InventoryFrame.Visible then
			ContextActionService:BindAction("RBXRemoveSlot", removeHotBarSlot, false, Enum.KeyCode.ButtonX)
		else
			ContextActionService:UnbindAction("RBXRemoveSlot")
		end

		BackpackScript.IsOpen = InventoryFrame.Visible
		BackpackScript.StateChanged:Fire(InventoryFrame.Visible)
	end

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	BackpackScript.OpenClose = openClose -- Exposed
end

-- Now that we're done building the GUI, we Connect to all the major events

-- Wait for the player if LocalPlayer wasn't ready earlier
while not Player do
	task.wait()
	Player = Players.LocalPlayer
end

-- Listen to current and all future characters of our player
Player.CharacterAdded:Connect(OnCharacterAdded)
if Player.Character then
	OnCharacterAdded(Player.Character)
end

do -- Hotkey stuff
	-- Listen to key down
	UserInputService.InputBegan:Connect(OnInputBegan)

	-- Listen to ANY TextBox gaining or losing focus, for disabling all hotkeys
	UserInputService.TextBoxFocused:Connect(function(): ()
		TextBoxFocused = true
	end)
	UserInputService.TextBoxFocusReleased:Connect(function(): ()
		TextBoxFocused = false
	end)

	-- Manual unequip for HopperBins on drop button pressed
	HotkeyFns[DROP_HOTKEY_VALUE] = function(): () --NOTE: HopperBin
		UnequipAllTools()
	end

	-- Listen to keyboard status, for showing/hiding hotkey labels
	UserInputService.Changed:Connect(OnUISChanged)
	OnUISChanged("KeyboardEnabled")

	-- Listen to gamepad status, for allowing gamepad style selection/equip
	if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
		gamepadConnected()
	end
	UserInputService.GamepadConnected:Connect(function(gamepadEnum: Enum.UserInputType): ()
		if gamepadEnum == Enum.UserInputType.Gamepad1 then
			gamepadConnected()
		end
	end)
	UserInputService.GamepadDisconnected:Connect(function(gamepadEnum: Enum.UserInputType): ()
		if gamepadEnum == Enum.UserInputType.Gamepad1 then
			gamepadDisconnected()
		end
	end)
end

function BackpackScript:SetBackpackEnabled(Enabled: boolean): ()
	BackpackEnabled = Enabled
end

function BackpackScript:IsOpened(): boolean
	return BackpackScript.IsOpen
end

function BackpackScript:GetBackpackEnabled(): boolean
	return BackpackEnabled
end

function BackpackScript:GetStateChangedEvent(): RBXScriptSignal
	return Backpack.StateChanged
end

RunService.Heartbeat:Connect(function(): ()
	OnIconChanged(BackpackEnabled)
end)

return BackpackScript
