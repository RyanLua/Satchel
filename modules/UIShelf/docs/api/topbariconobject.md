# TopBarIconObject

A top bar icon.

## Properties

### Name

The name of the icon.

* **string**

---

### Order

The layout order of the icon.

* **number**

---

### Area

The area of the icon. `1` is left and `2` is right.

* **number**

---

### CurrentState

The current input state of the icon.

* **string**

---

### Image

The icon image, can be the id itself or the URI.

* **number | string**

---

### NoticeCap

The notice cap string, an example of this is "99+" for the default.

* **string**

---

### Notices

The amount of notices the icon actually has.

* **number**

## Methods

### AddIconNotices

Adds notices to the parent topbar icon.

**Parameters**

* **notices:** `number?`\
The amount of notices to add, leaving this nil will add a single notice

* **noticeCap:** `number?`\
When to display a + sign after a set amount of notices, defaults to 99

**Returns**

* **void**

---

### RemoveIconNotices

Removes notices that are active in the icon.

**Parameters**

* **notices:** `number?`\
The amount of notices to remove, leave nil to remove all notices

**Returns**

* **void**

---

### BindKeyCodes

Binds multiple key codes to activate the icons `Activated` event.

**Parameters**

* **keyCodes:** `{ Enum.KeyCode }?`\
The key codes to listen to, if it is nil it will unbind all binded key codes

**Returns**

* **void**

---

### SetImageSize

Sets the image size of the icon, default is filled.

**Parameters**

* **imageSize:** `Vector2`\
The size to set the image to

**Returns**

* **void**

---

### SetIconEnabled

Sets the status of the icon visibility.

**Parameters**

* **enabled:** `boolean`\
Whether or not to enable the icon

**Returns**

* **void**

---

### BindGuiObject

Binds a GuiObject to the icon. This will toggle the visibility to the opposite when the icon is clicked.

**Parameters**

* **guiObject:** `GuiObject`\
The [GuiObject](https://create.roblox.com/docs/reference/engine/classes/GuiObject) to bind to activation, set to nil to unbind

**Returns**

* **void**

---

### SetTooltip

Adds a tooltip to the icon when hovering.

**Parameters**

* **text:** `string?`\
The text to put in the tooltip, leave this nil to remove the tooltip

**Returns**

* **void**

---

### SetTooltipEnabled

Sets the tooltips visibility forcibly.

**Parameters**

* **enabled:** `boolean`\
Whether or not the tooltip should show

**Returns**

* **void**

---

### SetImageRect

Sets the image rect size and offset. Useful if you are using a spritesheet image.

**Parameters**

* **rectSize:** `Rect`\
The [ImageLabel.ImageRectSize](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#ImageRectSize)

* **rectOffset:** `Rect`\
The [ImageLabel.ImageRectOffset](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#ImageRectOffset)

**Returns**

* **void**

---

### Destroy

Destroys the icon itself, removing it from the topbar.

**Returns**

* **void**

## Events

### Activated

Fires when the icon is activated, by any supported input type. Also passes in the user input type enum.

**Parameters**

* **inputType:** `Enum.UserInputType`\
The user input type that activated the icon

---

### NoticeAdded

Fires whenever a notice is added to the icon.

**Parameters**

* **noticeCount:** `number`\
The amount of notices added to the icon

---

### StateChanged

Fires whenever the state of the icon changes. For example: Hovering -> Default.

**Parameters**

* **newState:** `string`\
The latest state at the time of the event being fired