---
icon: lucide/book-marked
---

<style>
    .md-typeset__table {
      width: 100%;
    }

    .md-typeset__table table:not([class]) {
      display: table
    }
</style>

Satchel is a reskin of the default BackpackGui located in [CoreGui]. Satchel acts very similar to the default backpack and is based on a fork on the default backpack. Behaviors between the two should remain the same with both of them managing the [Backpack].

  [CoreGui]: https://create.roblox.com/docs/reference/engine/classes/CoreGui
  [Backpack]: https://create.roblox.com/docs/reference/engine/classes/Backpack

## Summary

### Attributes

| Attribute | Description | Default |
| :--- | :--- | :--- |
| BackgroundColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the background color of the default inventory window and slots. | `[25, 27, 29]` |
| BackgroundTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the background transparency of the default inventory window and slots. | 0.3 |
| CornerRadius: [`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim) | Determines the radius, in pixels, of the default inventory window and slots. | `0, 8` |
| EquipBorderColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the equip border when a slot is equipped. | `[255, 255, 255]` |
| EquipBorderSizePixel: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the pixel width of the equip border when a slot is equipped. | `5` |
| FontFace: [`Font`](https://create.roblox.com/docs/reference/engine/enums/Font) | Determines the font of the default inventory window and slots. | `Builder Sans` |
| InsetIconPadding: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the tool icon is padded in the default inventory window and slots. | True |
| OutlineEquipBorder: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the equip border is outline or inset when a slot is equipped. | True |
| TextColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text in default inventory window and slots. | `[255, 255, 255]` |
| TextSize: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the size of the text in the default inventory window and slots. | `14` |
| TextStrokeColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text stroke of text in default inventory window and slots. | `[0, 0, 0]` |
| TextStrokeTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the transparency of the text stroke of text in default chat window and slots. | 0.5 |

### Methods

| IsOpened(): [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) |
| :--- |
| Returns whether the inventory is opened or not. |

| SetBackpackEnabled(enabled: boolean): `void` |
| :--- |
| Sets whether the backpack gui is enabled or disabled. |

| GetBackpackEnabled(): [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) |
| :--- |
| Returns whether the backpack gui is enabled or disabled. |

| GetStateChangedEvent(): [`RBXScriptSignal`](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) |
| :--- |
| Returns a signal that fires when the inventory is opened or closed. |

## Attributes

### BackgroundColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the background color of the default inventory window and slots. Changing this will update the background color for all elements excluding the search box background for visibility purposes.

### BackgroundTransparency

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the background transparency of the default inventory window and slots. This will change how the hot bar looks in its locked state and the inventory background.

### CornerRadius

[`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim)

Determines the radius, in pixels, of the default inventory window and slots. This will affect all elements with a visible rounded corner. The corner radius for the search bar is calculated automatically based on this value.

### EquipBorderColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the equip border when a slot is equipped. The drag outline color of the slot will not changed by this.

### EquipBorderSizePixel

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the pixel width of the equip border when a slot is equipped. This additionally controls the padding of tool icons.

### FontFace

[`Enum.Font`](https://create.roblox.com/docs/reference/engine/enums/Font)

Determines the font of the default inventory window and slots. This includes all text in the Satchel UI.

!!! bug

    Rojo does not support the [Font](https://create.roblox.com/docs/reference/engine/datatypes/Font) instance attribute so the it will not be synced. You may add the attribute manually if you wish to adjust the font.

### InsetIconPadding

[`bool`](https://create.roblox.com/docs/luau/booleans)

Determines whether or not the tool icon is padded in the default inventory window and slots. Changing this will change how the tool icon is padded in the slot or not.

### OutlineEquipBorder

[`bool`](https://create.roblox.com/docs/luau/booleans)

Determines whether or not the equip border is outline or inset when a slot is equipped. Changing this will make the equip border either border will outline or inset the slot.

### TextColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the text in default inventory window and slots. This will change the color of all text.

### TextSize

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the size of the text in the default inventory window and slots. This will change the text size of the tool names and will not change other text like search text, hotkey number, and gamepad hints.

### TextStrokeColor3

[`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3)

Determines the color of the text stroke of text in default inventory window and slots. This will change the color of all text strokes which are visible.

### TextStrokeTransparency

[`number`](https://create.roblox.com/docs/luau/numbers)

Determines the transparency of the text stroke of text in default chat window and slots. This will change all text strokes in which text strokes are visible.

## Methods

### IsOpened

Returns whether the inventory is opened or not.

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
    </tr>
</table>

### SetBackpackEnabled

Sets whether the backpack gui is enabled or disabled.

#### Code Samples

This code sample will disable the backpack gui.

``` lua title="Disable Backpack"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

Satchel.SetBackpackEnabled(false)
```

#### Parameters

<table>
    <tr>
        <td>enabled: <a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
        <td>Whether to enable or disable the Backpack</td>
    </tr>
</table>

#### Returns

<table>
    <tr>
        <td>void</td>
    </tr>
</table>

### GetBackpackEnabled

Returns whether the backpack gui is enabled or disabled.

#### Code Samples

This code sample makes a TextButton that toggles the inventory when clicked.

``` lua title="Toggle Satchel"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

local button = Instance.new("TextButton")
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Position = UDim2.new(0.5, 0, 0.5, 0)
button.Text = "Toggle Inventory"
button.MouseButton1Click:Connect(function()
    if Satchel:GetBackpackEnabled() then
        Satchel.SetBackpackEnabled(false)
    else
        Satchel.SetBackpackEnabled(true)
    end
end)
```

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/luau/booleans">bool</a></td>
    </tr>
</table>

### GetStateChangedEvent

Returns a signal that fires when the inventory is opened or closed.

#### Code Samples

This code sample detects when the inventory is opened or closed.

``` lua title="Detect Inventory State"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Satchel = require(ReplicatedStorage.Satchel)

Satchel.GetStateChangedEvent():Connect(function(isOpened: boolean)
    if isOpened then
        print("Inventory opened")
    else
        print("Inventory closed")
    end
end)
```

#### Returns

<table>
    <tr>
        <td><a href="https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal">RBXScriptSignal</a></td>
    </tr>
</table>
