---
title: Usage
description: Use of Satchel very easy. Highly customizable using instance attributes and with scripting support.
icon: material/toolbox-outline
comments: true
tags:
  - Overview
  - Customization
  - Scripting
---

Use of Satchel after installation very easy. Just [publish your experience to Roblox](https://create.roblox.com/docs/production/publishing) and see Satchel live in action.

!!! note

    Please see [API Reference](api-reference.md) for more details on attributes, methods, and events for Satchel and how to use Satchel to it's full potential.

### Customization

Satchel is highly customizable & adjustable with [instance attributes](https://create.roblox.com/docs/studio/instance-attributes) support allowing you to customize the behavior and appearance of over 10+ attributes. Below see a table containing all the attributes along with a description of what that attribute does.

| Attribute | Description | Default |
| :--- | :--- | :--- |
| BackgroundColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the background color of the default inventory window and slots. | `[25, 27, 29]` |
| BackgroundTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the background transparency of the default inventory window and slots. | 0.3 |
| CornerRadius: [`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim) | Determines the radius, in pixels, of the default inventory window and slots. | `0, 8` |
| EquipBorderColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the equip border when a slot is equipped. | `[255, 255, 255]` |
| EquipBorderSizePixel: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the pixel width of the equip border when a slot is equipped. | `5` |
| FontFace: [`Font`](https://create.roblox.com/docs/reference/engine/enums/Font) | Determines the font of the default inventory window and slots. | `Gotham SSm` |
| InsetIconPadding: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the tool icon is padded in the default inventory window and slots. | True |
| OutlineEquipBorder: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the equip border is outline or inset when a slot is equipped. | True |
| TextColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text in default inventory window and slots. | `[255, 255, 255]` |
| TextSize: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the size of the text in the default inventory window and slots. | `14` |
| TextStrokeColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text stroke of text in default inventory window and slots. | `[0, 0, 0]` |
| TextStrokeTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the transparency of the text stroke of text in default chat window and slots. | 0.5 |

<figure markdown>
  ![Instance Attributes](https://github.com/RyanLua/Satchel/assets/80087248/a115e388-de55-4cfa-9c41-63b117df4b74)
  <figcaption>Example of customization using instance attributes</figcaption>
</figure>

### Scripting

Satchel offers methods and events for scripting purposes. Below see a table with all the methods available.

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
