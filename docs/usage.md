---
title: Usage
description: Use of Satchel very easy. Highly customizable using instance attributes and with scripting support.
icon: material/toolbox-outline
---

Use of Satchel after installation very easy. Just [publish your experience to Roblox](https://create.roblox.com/docs/production/publishing) and see Satchel live in action.

To learn how to install Satchel, see [Installation](installation.md).

!!! note

    Please see [API Reference](api-reference.md) for more details on attributes, methods, and events for Satchel and how to use Satchel to it's full potential.

### Customization

Satchel is highly customizable & adjustable with [instance attributes](https://create.roblox.com/docs/studio/instance-attributes) support allowing you to customize the behavior and appearance of over 10+ attributes.

Some of the attributes include:

* Text Color, Size, Stroke Color & Transparency
* Background Color & Transparency
* Equip Border Color & Thickness
* Corner Radius
* Font

More attributes can be found in the [API Reference](api-reference.md). The list above is not exhaustive and there are may more attributes available for customization.

<figure markdown>
  ![Instance Attributes](https://github.com/RyanLua/Satchel/assets/80087248/a115e388-de55-4cfa-9c41-63b117df4b74)
  <figcaption>Example of customization using instance attributes</figcaption>
</figure>

### Scripting

Satchel offers methods and events for scripting purposes. In the below code example we will use the `SetBackpackEnabled` method to disable the Satchel. The script expects the Satchel module to be in [`ReplicatedStorage`](https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage).

``` lua title="LocalScript" linenums="1"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Satchel = require(ReplicatedStorage:WaitForChild("Satchel"))

Satchel.SetBackpackEnabled(false) -- (1)!
```

1. Disable Satchel using the [SetBackpackEnabled](api-reference.md#setbackpackenabled) method.

For the full API reference, see [API Reference](api-reference.md) for more details on attributes, methods, and events for Satchel and how to use Satchel to it's full potential.
