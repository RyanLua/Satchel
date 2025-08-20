---
icon: material/download-outline
---

Installing Satchel is easy and painless. Satchel is a drag-and-drop module that works out of the box and with no configuration needed.

### Creator Marketplace

1. Get the Satchel module from the [Creator Marketplace](https://create.roblox.com/marketplace/asset/13947506401).

    ![Creator Marketplace](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/CreatorMarketplace.png){ width="100%" }

2. Open Roblox Studio and create a new place or open an existing place.

3. Open or locate the [Toolbox](https://create.roblox.com/docs/studio/toolbox).

    ![View Tab Toolbox](https://prod.docsiteassets.roblox.com/assets/studio/general/View-Tab-Toolbox.png)

4. Open your [Inventory](https://create.roblox.com/docs/studio/toolbox#inventory) from the [Toolbox](https://create.roblox.com/docs/studio/toolbox).

    ![Inventory Tab](https://prod.docsiteassets.roblox.com/assets/studio/toolbox/Inventory-Tab.png){ width="50%" }

5. Search for `Satchel` created by `WinnersTakesAll` and click on it.

    ![Toolbox](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/MarketplaceCard.png)

6. Insert `Satchel` into the [Explorer](https://create.roblox.com/docs/studio/explorer) and drag it into [StarterPlayerScripts](https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts).

    ![Explorer](https://github.com/RyanLua/Satchel/assets/80087248/97d51886-08b6-40bb-b16b-90433dd7d2b7){ width="50%" }

### GitHub Releases

1. Download the `Satchel.rbxmx` file from [Releases](https://github.com/RyanLua/Satchel/releases).

    ![GitHub Release](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/GitHubReleases.png){ width="75%" }

2. Open Roblox Studio and create a new place or open an existing place.

3. Go to [Explorer](https://create.roblox.com/docs/studio/explorer) and right-click on [`StarterPlayerScripts`](https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts) and click on `Insert from file...`.

    ![Insert From File](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/InsertFromFile.png){ width="75%" }

4. Select the `Satchel.rbxmx` you downloaded from GitHub and click `Open`.

    ![Upload File](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/SelectFile.png){ width="75%" }

5. Ensure that `Satchel`is in [StarterPlayerScripts](https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts).

    ![Explorer](https://github.com/RyanLua/Satchel/assets/80087248/97d51886-08b6-40bb-b16b-90433dd7d2b7){ width="50%" }

### Wally

1. Open your Rojo project in the code editor of your choice.

2. Install [Wally](https://wally.run/install) to your project.

3. Initialize Wally using `wally init`.

4. In the new `wally.toml` file, add `satchel = "ryanlua/satchel@1.2.0"`. Be sure to use the latest version.

5. Install Satchel from Wally by running `wally install`. Satchel should appear under `project/Packages`. Don't forget to add `Packages` to your [`.gitignore`](http://git-scm.com/docs/gitignore)

6. In a [`LocalScript`](https://create.roblox.com/docs/reference/engine/classes/LocalScript) under [`StarterPlayerScripts`](https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts), require Satchel from the installation location of Wally. Default is `ReplicatedStorage.Packages`.

```lua title="LocalScript"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Satchel = ReplicatedStorage.Packages.Satchel -- Make sure this points to where Satchel is

require(Satchel)
```
