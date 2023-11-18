# UIShelf

Allows you to create top bar icons that 1:1 with CoreGui.

## Properties

### HorizontalAlignment <Badge type="info" text="Enum" />

Just a shortcut for the area of an icon, useful if you forget.

* **Enum**

---

### CreatedIcons

A table of every topbar icon created.

* **{ [TopBarIconObject](/api/topbariconobject) }**

---

### TopBarEnabled

Whether or not the topbar is enabled for UIShelf.

* **boolean**

## Functions

### CreateIcon

Creates a new topbar icon, with declared properties.

**Parameters**

* **properties:** `{ [string]: string | number }`\
The properties to set on the icon

**Returns**

* **[TopBarIconObject](/api/topbariconobject)**

---

### CreateSpacer

Creates a new topbar spacer, acts a spacer to other icons.

**Parameters**

* **properties:** `{ [string]: string | number }`\
The properties to set on the spacer

* **bypass:** `boolean?`\
Allows you to bypass the order restrictions, should only be used internally

**Returns**

* **[TopBarSpacerObject](/api/topbarspacerobject)**

---

### CreateMenuItem

Creates a new menu item for use inside of a menu.

**Parameters**

* **properties:** `{ [string]: string | number }`\
The properties to set on the spacer

**Returns**

* **[MenuItemObject](/api/menuitemobject)**

---

### SetTopBarEnabled

Sets whether or not the top bar is enabled, only applies to UIShelf icons.

**Parameters**

* **enabled** `boolean`\
Whether or not to enable the topbar

**Returns**

* **void**