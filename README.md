<h1 align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/SatchelWhite.png">
    <source media="(prefers-color-scheme: light)" srcset="assets/SatchelBlack.png">
    <img src="assets/SatchelBlack.png">
  </picture>
  
  [![GitHub release](https://img.shields.io/github/v/release/RyanLua/Satchel?include_prereleases&logo=robloxstudio&logoColor=white&color=00a2ff)](https://github.com/RyanLua/Satchel/releases)
  [![GitHub top language](https://img.shields.io/github/languages/top/RyanLua/Satchel?logo=lua&color=00a2ff)](https://github.com/search?q=repo%3ARyanLua%2FShime++language%3ALua&type=code)
  [![GitHub license](https://img.shields.io/github/license/RyanLua/Satchel?logo=gnu&color=00a2ff)](LICENSE.txt)
</h1>

> Satchel, a modern open-source alternative to Roblox's default backpack.

## About

Satchel is a modern open-source alternative to Roblox's default backpack. Satchel aims to be more customizable and easier to use than the default backpack while still having a "vanilla" feel. Installation of Satchel is as simple as dropping the module into your game and setting up a few properties if you like to customize it. It has a familiar feel and structure as to the default backpack for ease of use for both developers and players.

<img src="assets/SatchelThumbnail1.png" style="width: 49%;"> <img src="assets/SatchelThumbnail2.png" style="width: 49%;">
<img src="assets/SatchelThumbnail3.png" style="width: 49%;"> <img src="assets/SatchelThumbnail4.png" style="width: 49%;">

## Playground

> **Note**
>
> [Satchel Playground](https://www.roblox.com/games/13592168150) has Content Sharing enabled. You can download the demo from the Roblox website by clicking the ellipsis (`...`)and selecting `Edit`.

We provide an open-source demo of Satchel, you can [view the demo](https://www.roblox.com/games/13592168150) on Roblox.

[![Satchel Playground Thumbnail 1](https://github.com/RyanLua/Satchel/assets/80087248/e4c58793-05cc-4102-9d5e-a8b961915669)](https://www.roblox.com/games/13592168150)

Feel free to use the demo as a reference for how to use Satchel. Please download and modify towards your liking.

## Installation

Installation of Satchel is easy and painless. Satchel is a drag-and-drop module that works out of the box and with easy customization. Below are different ways to get you to download and install Satchel.

### GitHub

### Creator Marketplace

## Acknowledgements

A special thanks to the following people for their contributions to Satchel.

| Roblox Username | Contribution |
| --- | --- |
| [@OnlyTwentyCharacters](https://www.roblox.com/users/28969907/profile), [@SolarCrane](https://www.roblox.com/users/29373363/profile) | Creating the original CoreGui script |
| [@thebrickplanetboy](https://www.roblox.com/users/525495863/profile) | Allowing me to republish & modify his fork of the backpack system |

## Support

Satchel fully supports all platforms which includes computer, tablet, phone, console, and VR. If you see an issue with Satchel and would like to report it, see [SUPPORT.md](SUPPORT.md) for additional information.

You can support Satchel by starring this repository, sharing it with others, and contributing to it. Learn about contributing to Satchel below at [Contributing](#contributing).

## Documentation

Satchel supports instance attributes allowing you to change and customize many aspects including various behaviors in a friendly easy-to-use interface without having to touch any code. Below see all attributes.

### Attributes

| Attribute | Details |
| :--- | :--- |
| BackgroundColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the background color of the default inventory window and slots. |
| BackgroundTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the background transparency of the default inventory window and slots. |
| CornerRadius: [`UDim`](https://create.roblox.com/docs/reference/engine/datatypes/UDim) | Determines the radius, in pixels, of the default inventory window and slots. |
| EquipBorderColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the equip border when a slot is equipped. |
| EquipBorderSizePixel: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the pixel width of the equip border when a slot is equipped. |
| InsetIconPadding: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the tool icon is padded in the default inventory window and slots. |
| OutlineEquipBorder: [`boolean`](https://create.roblox.com/docs/scripting/luau/booleans) | Determines whether or not the equip border is outline or inset when a slot is equipped. |
| TextColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text in default inventory window and slots. |
| TextSize: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the size of the text in the default inventory window and slots. |
| TextStrokeColor3: [`Color3`](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Determines the color of the text stroke of text in default inventory window and slots. |
| TextStrokeTransparency: [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | Determines the transparency of the text stroke of text in default chat window and slots. |

<!-- Enums aren't supported by Rojo so this is commented out for now until a fix is available.

| EquipBorderMode: [`BorderMode`](https://create.roblox.com/docs/reference/engine/enums/BorderMode) | Determines in what manner the equip border is laid out relative to its dimensions when a slot is equipped. |
| FontFace: [`Font`](https://create.roblox.com/docs/reference/engine/enums/Font) | Determines the font of the default inventory window and slots. |

-->

## Contributing

We welcome all contributions from the community. If you would like to contribute, please see [CONTRIBUTING.md](CONTRIBUTING.md) to get started on how to contribute to Satchel.

When you contribute to Satchel you will be accredited for your contribution for everyone to see on this repository along with supporting the open-source community.

## License

Shime is licensed under [GNU General Public License v3.0](https://www.gnu.org/licenses/). See [LICENSE.txt](LICENSE.txt) for details.
