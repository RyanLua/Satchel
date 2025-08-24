---
icon: material/download-outline
---

Installing Satchel is easy and painless. Satchel is a drag-and-drop module that works out of the box and with no configuration needed.

## Creator Store <small>recommended</small> { #creator-store data-toc-label="Creator Store" }

1. Get the Satchel module from the [Creator Store].

    ![Creator Store](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/CreatorMarketplace.png){ width="100%" }

1. Open Roblox Studio and create a new place or open an existing place.

1. Open or locate the [Toolbox].

    ![View Tab Toolbox](https://prod.docsiteassets.roblox.com/assets/studio/general/View-Tab-Toolbox.png)

1. Open your [Inventory] from the [Toolbox].

    ![Inventory Tab](https://prod.docsiteassets.roblox.com/assets/studio/toolbox/Inventory-Tab.png){ width="50%" }

1. Search for `Satchel` created by `WinnersTakesAll` and click on it.

    ![Toolbox](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/MarketplaceCard.png)

1. Insert `Satchel` into the [Explorer] and drag it into [StarterPlayerScripts].

    ![Explorer](https://github.com/RyanLua/Satchel/assets/80087248/97d51886-08b6-40bb-b16b-90433dd7d2b7){ width="50%" }

  [Creator Store]: https://create.roblox.com/store/asset/13947506401
  [Inventory]: https://create.roblox.com/docs/studio/toolbox#inventory
  [Explorer]: https://create.roblox.com/docs/studio/explorer
  [Toolbox]: https://create.roblox.com/docs/studio/toolbox
  [StarterPlayerScripts]: https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts

## GitHub Releases

1. Download the `Satchel.rbxmx` file from [Releases].

    ![GitHub Release](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/GitHubReleases.png){ width="75%" }

1. Open Roblox Studio and create a new place or open an existing place.

1. Go to [Explorer] and right-click on [`StarterPlayerScripts`][StarterPlayerScripts] and click on `Insert from file...`.

    ![Insert From File](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/InsertFromFile.png){ width="75%" }

1. Select the `Satchel.rbxmx` you downloaded from GitHub and click `Open`.

    ![Upload File](https://raw.githubusercontent.com/RyanLua/Satchel/main/assets/SelectFile.png){ width="75%" }

1. Ensure that `Satchel`is in [StarterPlayerScripts].

    ![Explorer](https://github.com/RyanLua/Satchel/assets/80087248/97d51886-08b6-40bb-b16b-90433dd7d2b7){ width="50%" }

  [Releases]: https://github.com/RyanLua/Satchel/releases

## Wally

You are expected to already have Wally setup in your Rojo project and basic knowledge on how to use Wally packages.

1. Open your Rojo project in the code editor of your choice.

1. In the `wally.toml` file, add the [latest Wally version for Satchel][Wally]. Your dependencies should look similar to this:

    ``` toml title="wally.toml"
    [dependencies]
    satchel = "ryanlua/satchel@1.0.0"
    ```

1. Install Satchel from Wally by running `wally install`.

  [Wally]: https://wally.run/package/ryanlua/satchel
