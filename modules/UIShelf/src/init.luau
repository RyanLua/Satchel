--!strict

local UIShelf = { }
local TopBarIconObject = { }
local TopBarSpacerObject = { }
local TopBarUnibarObject = { }

-- // Variables

TopBarSpacerObject.__index = TopBarSpacerObject
TopBarIconObject.__index = TopBarIconObject
TopBarUnibarObject.__index = TopBarUnibarObject
UIShelf.__index = UIShelf

UIShelf.CreatedIcons = { }
UIShelf.TopBarEnabled = true

local PlayerService = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local UIElements = script.UIElements
local CurrentCamera = workspace.CurrentCamera

local Player = PlayerService.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local TopbarScreenGui = require(UIElements.TopBarApp):Clone()
local TooltipScreenGui = require(UIElements.TooltipLayer):Clone()
local LeftFrame = TopbarScreenGui.TopBarFrame.LeftFrame
local RightFrame = TopbarScreenGui.TopBarFrame.RightFrame

local TopbarIconBadge = require(UIElements.Badge)
local TopbarIcon = require(UIElements.Icon)
local TopbarSpacer = require(UIElements.Spacer)
local IconTooltip = require(UIElements.Tooltip)
local MenuObject = require(UIElements.MenuObject)
local SelectionImageObject = require(UIElements.SelectionImageObject)
local MenuSelectionImageObject = require(UIElements.SelectionImageObjectMenu)

local Signal = require(script.Parent.Signal)

local DEFAULT_TRANSPARENCYOUT_TWEENINFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local DEFAULT_TRANSPARENCYIN_TWEENINFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local NOTICE_UI_PADDING = 14
local NOTICE_UI_MARGIN = 24
local NOTICE_UI_MARGIN_24X24 = 0
local DEFAULT_ICON_SIZE = 44

local STATEOVERLAY_PROPERTIES = {
	Default = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	},
	Hovering = {
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	},
	MouseDown = {
		BackgroundTransparency = 0.7,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	},
	MouseUpHovering = {
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	},
}

local STATEOVERLAY_MENU_PROPERTIES = {
	Default = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	},
	Hovering = {
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	},
	MouseDown = {
		BackgroundTransparency = 0.7,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	},
}

local _STATEOVERLAY_UNIBAR_PROPERTIES = {
	Default = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	},
	Hovering = {
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	},
	Open = {
		BackgroundTransparency = 0.9,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	}
}

local EVENTS_FOR_CONNECTION_ICON = {
	MouseButton1Up = "MouseUpHovering",
	MouseButton1Down = "MouseDown",
	MouseEnter = "Hovering",
	MouseLeave = "Default",
	SelectionGained = "Hovering",
	SelectionLost = "Default",
}

local EVENTS_FOR_CONNECTION_MENU = {
	MouseButton1Up = "Hovering",
	MouseButton1Down = "MouseDown",
	MouseEnter = "Hovering",
	MouseLeave = "Default",
}

local _EVENTS_FOR_CONNECTION_UNIBAR = {
	MouseButton1Up = "Hovering",
	MouseButton1Down = "Hovering",
	MouseEnter = "Hovering",
	MouseLeave = "Default",
}

local DEFAULT_ICON_SIZE_UDIM = UDim2.fromOffset(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)

local DEFAULT_PADDING_SIZE_LEFT_UDIM,
_DEFAULT_PADDING_SIZE_RIGHT_UDIM = UDim.new(0, 42), UDim.new(0, 12)

local NOIMAGE_PADDING_SIZE_LEFT_UDIM,
NOIMAGE_PADDING_SIZE_RIGHT_UDIM = UDim.new(0, 12), UDim.new(0, 12)

local NOIMAGE_ICON_SIZE_UDIM = UDim2.fromOffset(0, DEFAULT_ICON_SIZE)

UIShelf.HorizontalAlignment = {
	Left = 1,
	Right = 2,
}

TopbarScreenGui.Parent = PlayerGui
TooltipScreenGui.Parent = PlayerGui

-- // Types

type IconProps = {
	Name: string,
	Image: string | number?,
	Order: number,
	Area: number,
	Text: string?,
	Font: Font | Enum.Font?,
}

type SpacerProps = {
	Name: string,
	Order: number,
	Area: number,
}

type MenuItemProps = {
	Name: string,
	Image: string | number,
}

assert(RunService:IsClient(), "UI can only be handled on the client")

-- // Functions

local function UpdateTopbar()
	local Inset = GuiService.TopbarInset

	TopbarScreenGui.TopBarFrame.Size = UDim2.fromOffset(
		Inset.Width, TopbarScreenGui.TopBarFrame.Size.Y.Offset
	)
end

function UIShelf.CreateIcon(properties: IconProps)
	local self = setmetatable({ }, TopBarIconObject)
	local IconClone = TopbarIcon:Clone()
	
	table.insert(UIShelf.CreatedIcons, self)

	local IconBackground = IconClone.Background
	local IconImage = IconBackground.Icon
	
	IconBackground.SelectionImageObject = SelectionImageObject

	self._Element = IconClone
	self._Tooltip = nil
	self._TooltipTweens = nil
	self.TooltipText = ""
	self.IsTooltipFarRight = false
	
	self.Name = nil
	self.Image = nil
	self.Order = nil
	self.Area = nil
	self.Text = nil
	
	self.TextEnabled = if properties.Text then true else false
	self.ImageEnabled = if properties.Image then true else false
	
	self.StateChanged = Signal() :: Signal.Signal<string>
	self.Activated = Signal() :: Signal.Signal<Enum.UserInputType>
	self.NoticeAdded = Signal() :: Signal.Signal<number>
	self.NoticeRemoved = Signal() :: Signal.Signal<number>

	self.Notices = 0
	self.NoticeCap = "99+"
	self.NoticeCapNum = 99
	self.CurrentState = "Default"

	self._KeyCodeConnection = nil
	self._NoticeConnection = nil
	self._TooltipConnection = nil
	self._GuiBindConnection = nil
	self._SizeConnection = nil
	
	if type(properties.Image) == "number" then
		properties.Image = `rbxassetid://{properties.Image}`
	end

	if properties.Order <= 0 then
		error("Order cannot be less than 0")
	end

	if properties.Area == UIShelf.HorizontalAlignment.Right then
		properties.Order = -properties.Order
	end

	for name, value in properties :: any do
		self[name] = value
	end

	IconBackground.Activated:Connect(function(inputObject)
		self.Activated:Fire(inputObject.UserInputType)
	end)
	
	self:SetText(properties.Text, properties.Font)
	self:SetImage(properties.Image)

	for connection, state in EVENTS_FOR_CONNECTION_ICON :: any do
		IconBackground[connection]:Connect(function()
			self:UpdateStateOverlay(state)
		end)
	end

	self.StateChanged:Connect(function(newState)
		if not self._Tooltip then
			return
		end

		if newState == "MouseUpHovering" or newState ~= "Hovering" then
			self:SetTooltipEnabled(false)
			return
		end

		task.wait(0.75)

		local LatestState = self.CurrentState

		if LatestState == "Hovering" and self._Tooltip then
			self:SetTooltipEnabled(true)
		end
	end)
	
	self._SizeConnection = IconBackground:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		IconClone.Size = UDim2.fromOffset(IconBackground.AbsoluteSize.X, 44)
	end)

	if self.Area == 1 then
		IconClone.Parent = LeftFrame
	elseif self.Area == 2 then
		IconClone.Parent = RightFrame
	end

	IconClone:SetAttribute("Notices", 0)

	IconClone.Name = properties.Name
	IconClone.LayoutOrder = properties.Order
	
	if properties.Image then
		IconImage.Image = properties.Image
	end

	return self
end

function UIShelf.SetTopBarEnabled(enabled: boolean)
	TopbarScreenGui.Enabled = enabled
	UIShelf.TopBarEnabled = enabled
end

function TopBarIconObject:SetIconEnabled(enabled: boolean)
	self._Element.Visible = enabled
end

function TopBarIconObject:BindGuiObject(guiObject: GuiObject?)
	if not guiObject then
		self._GuiBindConnection:Disconnect()
		return
	end

	if not self._GuiBindConnection then
		self._GuiBindConnection = self.Activated:Connect(function()
			guiObject.Visible = not guiObject.Visible
		end)
	end
end

function TopBarIconObject:SetText(text: string?, textFont: Enum.Font | Font?)
	local IconBackground = self._Element.Background
	local IconText = IconBackground.Text
	
	if not text then
		assert(self.ImageEnabled, "Must have at least image or text on icon")
		self.ImageEnabled = true
		IconText.Visible = false
			
		UpdateTopbar()
		self.TextEnabled = false
		return
	end
	
	self.TextEnabled = true
	
	IconBackground.Text.Visible = true
	IconBackground.Text.Text = text

	if textFont then
		IconBackground.Text.FontFace = if typeof(textFont) == "Font" then textFont else Font.fromEnum(textFont)
	end

	if not self.ImageEnabled then
		self.ImageEnabled = false
		IconBackground.Text.Inset.PaddingLeft = NOIMAGE_PADDING_SIZE_LEFT_UDIM
		IconBackground.Text.Inset.PaddingRight = NOIMAGE_PADDING_SIZE_RIGHT_UDIM
		IconBackground.Size = NOIMAGE_ICON_SIZE_UDIM
	end

	UpdateTopbar()
end

function TopBarIconObject:SetImage(image: string | number?)
	local IconBackground = self._Element.Background
	local IconText = IconBackground.Text
	local IconImage = IconBackground.Icon
	
	if not image then
		assert(self.TextEnabled, "Must have at least image or text on icon")
		IconImage.Image = ""
		self.TextEnabled = true
		IconText.Inset.PaddingLeft = NOIMAGE_PADDING_SIZE_LEFT_UDIM
		IconText.Inset.PaddingRight = NOIMAGE_PADDING_SIZE_RIGHT_UDIM
			
		IconBackground.Size = NOIMAGE_ICON_SIZE_UDIM
		UpdateTopbar()
		self.ImageEnabled = false
		return
	end
	
	self.ImageEnabled = true
	IconText.Inset.PaddingLeft = DEFAULT_PADDING_SIZE_LEFT_UDIM
	
	if type(image) == "number" then
		image = `rbxassetid://{image}`
	end
	
	IconImage.Image = image
	IconBackground.Size = DEFAULT_ICON_SIZE_UDIM
	
	UpdateTopbar()
end

function TopBarIconObject:SetTooltip(text: string?)
	if not text then
		self._Tooltip:Destroy()
		self._Tooltip = nil

		for _, tween in self._TooltipTweens do
			tween:Destroy()
		end

		table.clear(self._TooltipTweens)
		return
	end

	if not self._Tooltip then
		self._Tooltip = IconTooltip:Clone()
		self._Tooltip.Parent = TooltipScreenGui

		self._TooltipTweens = {
			[false] = TweenService:Create(self._Tooltip, DEFAULT_TRANSPARENCYOUT_TWEENINFO, {
				GroupTransparency = 1
			}),
			[true] = TweenService:Create(self._Tooltip, DEFAULT_TRANSPARENCYIN_TWEENINFO, {
				GroupTransparency = 0
			}),
		}
	end

	local IconTooltipElement = self._Tooltip
	local TooltipHeader = IconTooltipElement.Box.Header
	local TooltipCaret = IconTooltipElement.Caret
	local TopBarIcon = self._Element

	if TooltipHeader.Text == text then
		return
	end

	TooltipHeader.Text = text

	local TOOLTIP_POSITION = TopBarIcon.AbsolutePosition.X + (TopBarIcon.AbsoluteSize.X / 2)
	local SHADOW_SIZE = UDim2.fromOffset(self._Tooltip.Box.AbsoluteSize.X + 8, self._Tooltip.Box.AbsoluteSize.Y + 8)

	IconTooltipElement.Position = UDim2.fromOffset(TOOLTIP_POSITION, 56)
	IconTooltipElement.Size = UDim2.fromOffset(self._Tooltip.Box.AbsoluteSize.X + 8, 53)
	IconTooltipElement.DropShadow.Size = SHADOW_SIZE

	TooltipCaret.Position = UDim2.fromOffset(TOOLTIP_POSITION - IconTooltipElement.AbsolutePosition.X, 4)

	if not self._TooltipConnection then
		local ConnectionDebounce = false

		self._TooltipConnection = GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
			if ConnectionDebounce then
				return
			end

			ConnectionDebounce = true

			if self.IsTooltipFarRight then
				IconTooltipElement.Position = UDim2.fromOffset(
					CurrentCamera.ViewportSize.X - 8 - (IconTooltipElement.Box.AbsoluteSize.X / 2), 56
				)
				
				task.wait(0.25)
				ConnectionDebounce = false
				return
			end

			task.wait(0.25)

			IconTooltipElement.Position = UDim2.fromOffset(TopBarIcon.AbsolutePosition.X + (TopBarIcon.AbsoluteSize.X / 2), 56)
			ConnectionDebounce = false
		end)
	end

	if self.Area == UIShelf.HorizontalAlignment.Right and self._Element.LayoutOrder == -1 then
		self.IsTooltipFarRight = true

		TooltipCaret.Position = UDim2.fromOffset(
			IconTooltipElement.Box.AbsoluteSize.X - 22, 4
		)

		IconTooltipElement.Position = UDim2.fromOffset(
			CurrentCamera.ViewportSize.X - 8 - (IconTooltipElement.Box.AbsoluteSize.X / 2), 56
		)
	end
end

function TopBarIconObject:SetTooltipEnabled(enabled: boolean)
	if not self._Tooltip then
		error("Icon must already have a tooltip set")
		return
	end

	self._Tooltip:TweenPosition(
		UDim2.fromOffset(self._Tooltip.Position.X.Offset, if enabled then 60 else 56),
		if enabled then Enum.EasingDirection.In else Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.15
	)

	if enabled then
		self._Tooltip.Visible = enabled
		self._TooltipTweens[enabled]:Play()
	else
		self._TooltipTweens[enabled]:Play()
		task.wait(0.15)
		self._Tooltip.Visible = enabled
	end
end

function TopBarIconObject:CreateMenu(menuContents: {typeof(UIShelf.CreateMenuItem({Name = "", Image = 0}))})
	local TopBarIcon = self._Element
	local MenuContainer = TopBarIcon.MenuContainer

	if MenuContainer.ScrollingFrame:FindFirstChildOfClass("ImageButton") then
		for _, instance in MenuContainer.ScrollingFrame:GetChildren() do
			if instance:IsA("ImageButton") then
				instance:Destroy()
			end
		end
	end

	for _, menuContents in menuContents do
		local MenuObjectClone = MenuObject:Clone()
		local MenuObjectLabel = MenuObjectClone.StyledTextLabel
		local MenuObjectIcon = MenuObjectClone.IconHost.IntegrationIconFrame.IntegrationIcon

		for connection, state in EVENTS_FOR_CONNECTION_MENU :: any do
			MenuObjectClone[connection]:Connect(function()
				if connection == "MouseButton1Up" then
					MenuContainer.Visible = false
					menuContents.Activated:Fire()
				end

				self:_UpdateStateOverlayMenu(state, MenuObjectClone)
			end)
		end

		MenuObjectClone.Name = string.lower(menuContents.Name)
		MenuObjectClone.SelectionImageObject = MenuSelectionImageObject
		MenuObjectLabel.Text = menuContents.Name
		MenuObjectIcon.Image = menuContents.Image

		MenuObjectClone.Parent = MenuContainer.ScrollingFrame
	end

	MenuContainer.Position = UDim2.new(1, 0, 0, 54)
	
	if self.Area == UIShelf.HorizontalAlignment.Left then
		MenuContainer.Position = UDim2.fromOffset(0, 54)
		MenuContainer.AnchorPoint = Vector2.new(0, 0)
	end

	self.Activated:Connect(function()
		MenuContainer.Visible = not MenuContainer.Visible
	end)
end

function TopBarIconObject:_UpdateStateOverlayMenu(newState: "Default" | "Hovering" | "MouseDown", button: any)
	for property, value in STATEOVERLAY_MENU_PROPERTIES[newState] do
		if button[property] then
			button[property] = value
		end
	end
end

function TopBarIconObject:UpdateStateOverlay(newState: "Default" | "Hovering" | "MouseDown" | "MouseUpHovering")
	local IconBackground = self._Element.Background
	local IconStateOverlay = IconBackground.StateOverlayRound

	if newState == "Hovering" and UserInputService.TouchEnabled then
		IconStateOverlay.Transparency = 0.7
		IconStateOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		return
	end

	for property, value in STATEOVERLAY_PROPERTIES[newState] do
		IconStateOverlay[property] = value
	end

	self.CurrentState = newState
	self.StateChanged:Fire(newState)
end

function TopBarIconObject:SetImageRect(rectSize: Rect, rectOffset: Rect)
	local IconImage = self._Element.Background.Icon

	IconImage.ImageRectOffset = rectOffset
	IconImage.ImageRectSize = rectSize
end

function TopBarIconObject:AddIconNotices(notices: number?, noticeCap: number?)
	noticeCap = noticeCap or 99
	notices = notices or 1

	if notices and notices <= 0 then
		error("Cannot notify 0 notifications")
		return
	end

	local TopBarIcon = self._Element
	local BadgeContainer = TopBarIcon.BadgeContainer
	
	if not TopbarIcon:GetAttribute("Notices") then
		TopbarIcon:SetAttribute("Notices", 0)
	end

	if not BadgeContainer:FindFirstChild("Badge") then
		local TopbarIconBadgeClone = TopbarIconBadge:Clone()
		TopbarIconBadgeClone.Parent = BadgeContainer
	end

	local Badge = BadgeContainer.Badge
	local BadgeText = Badge.Inner.TextLabel

	if noticeCap and noticeCap ~= self.NoticeCapNum then
		self.NoticeCap = `{noticeCap}+`
	end

	if not self._NoticeConnection then
		self._NoticeConnection = TopBarIcon:GetAttributeChangedSignal("Notices"):Connect(function()
			local NewValue = TopBarIcon:GetAttribute("Notices")
			BadgeText.Text = NewValue

			if NewValue >= 1 then
				BadgeContainer.Visible = true
			elseif NewValue == 0 then
				BadgeContainer.Visible = false
				self.Notices = 0
			end

			if NewValue > noticeCap then
				BadgeText.Text = self.NoticeCap
			end
			
			if NewValue <= 9 then
				Badge.Size = UDim2.fromOffset(24, 24)
				Badge.Position = UDim2.new(1, NOTICE_UI_MARGIN_24X24, 0, 0)
				return
			end
			
			Badge.Size = UDim2.fromOffset(BadgeText.TextBounds.X + NOTICE_UI_PADDING, 24)
			Badge.Position = UDim2.new(1, BadgeText.TextBounds.X + NOTICE_UI_PADDING - NOTICE_UI_MARGIN, 0, 0)
		end)
	end

	TopBarIcon:SetAttribute("Notices", TopBarIcon:GetAttribute("Notices") + notices)

	self.NoticeAdded:Fire(TopBarIcon:GetAttribute("Notices"))
	self.Notices += notices
end

function TopBarIconObject:RemoveIconNotices(notices: number?)
	local TopBarIcon = self._Element

	if not notices then
		TopBarIcon:SetAttribute("Notices", 0)
		self.Notices = 0
		return
	end

	if notices <= 0 then
		error("Cannot remove 0 notifications")
		return
	end

	TopBarIcon:SetAttribute(
		"Notices",
		TopBarIcon:GetAttribute("Notices")
		- notices
	)

	self.Notices -= notices
end

function TopBarIconObject:BindKeyCode(keyCode: Enum.KeyCode?)
	if not keyCode then
		if self._Tooltip then
			local HotKeyFrame = self._Tooltip.Box.Hotkeys
			local FirstHotKey = HotKeyFrame["1"]

			HotKeyFrame.Visible = false
			FirstHotKey.LabelContent.Text = "nil"
		end

		if self._KeyCodeConnection then
			self._KeyCodeConnection:Disconnect()
		end
		
		return
	end

	if self._Tooltip then
		local HotKeyFrame = self._Tooltip.Box.Hotkeys
		local FirstHotKey = HotKeyFrame["1"]
		local KeyCodeName = if keyCode.Name == "Escape" then "Esc" else keyCode.Name
		
		HotKeyFrame.Visible = true
		FirstHotKey.LabelContent.Text = KeyCodeName

		local SHADOW_SIZE = UDim2.fromOffset(self._Tooltip.Box.AbsoluteSize.X + 8, self._Tooltip.Box.AbsoluteSize.Y + 8)
		self._Tooltip.DropShadow.Size = SHADOW_SIZE
	end

	self._KeyCodeConnection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
		if gameProcessedEvent then
			return
		end

		if input.KeyCode == keyCode then
			self.Activated:Fire(input.UserInputType)
		end
	end)
end

function TopBarIconObject:SetImageSize(imageSize: Vector2)
	local TopBarIcon = self._Element
	local TopBarIconImage = TopBarIcon.Background.Icon

	TopBarIconImage.Size = UDim2.fromOffset(imageSize.X, imageSize.Y)
end

function TopBarIconObject:Destroy()
	if self._KeyCodeConnection then
		self._KeyCodeConnection:Disconnect()
	end

	if self._NoticeConnection then
		self._NoticeConnection:Disconnect()
	end

	for _, value in self do
		if typeof(value) == "Instance" then
			value:Destroy()
			continue
		end

		self[value] = nil
	end

	table.remove(UIShelf.CreatedIcons, table.find(UIShelf.CreatedIcons, self))
	setmetatable(self, nil)
end

function UIShelf.CreateSpacer(properties: SpacerProps, bypass: boolean?)
	local self = setmetatable({ }, TopBarSpacerObject)
	local SpacerClone = TopbarSpacer:Clone()

	if properties.Order <= 0 and not bypass then
		error("Order cannot be less than 0")
	end

	if properties.Area == 2 then
		properties.Order = -properties.Order
	end

	self._Element = SpacerClone
	self.Name = properties.Name
	self.Order = properties.Order
	self.Area = properties.Area

	if self.Area == 1 then
		SpacerClone.Parent = LeftFrame
	elseif self.Area == 2 then
		SpacerClone.Parent = RightFrame
	end

	SpacerClone.Name = properties[1]
	SpacerClone.LayoutOrder = properties[3]

	return self
end

function TopBarSpacerObject:SetSpacerEnabled(enabled: boolean)
	local TopBarSpacer = self._Element

	TopBarSpacer.Visible = enabled
end

function TopBarSpacerObject:SetSpacerSize(size: number)
	local TopBarSpacer = self._Element

	TopBarSpacer.Size = UDim2.fromOffset(size, TopBarSpacer.Size.Y.Offset)
end

function TopBarSpacerObject:Destroy()
	for _, value in self do
		if typeof(value) == "Instance" then
			value:Destroy()
			continue
		end

		self[value] = nil
	end

	setmetatable(self, nil)
end

function UIShelf.CreateMenuItem(properties: MenuItemProps)
	local MenuItemObject = { }

	if type(properties.Image) == "number" then
		properties.Image = `rbxassetid://{properties.Image}`
	end

	MenuItemObject.Name = properties.Name
	MenuItemObject.Image = properties.Image

	MenuItemObject.Activated = Signal() :: Signal.Signal<>

	return MenuItemObject
end

-- // Connections

GuiService.MenuOpened:Connect(function()
	TopbarScreenGui.Enabled = false
end)

GuiService.MenuClosed:Connect(function()
	TopbarScreenGui.Enabled = UIShelf.TopBarEnabled
end)

GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(UpdateTopbar)

RunService.Heartbeat:Connect(function()
	if not GuiService.SelectedObject then
		return
	end
	
	MenuSelectionImageObject.UIStroke.GradientChild.Rotation += 1
	SelectionImageObject.UIStroke.GradientChild.Rotation += 1
end)

-- // Actions

UpdateTopbar()

return UIShelf