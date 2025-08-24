---
icon: material/download-outline
---

Installing Satchel is easy and painless. Satchel is a drag-and-drop module that works out of the box and with no configuration needed.

!!! tip

    While Satchel can run anywhere because it uses [RunContext], it is recommeneded to parent Satchel to [`ReplicatedStorage`][ReplicatedStorage] for best practices and organizational reasons.

  [RunContext]: https://devforum.roblox.com/t/1938784
  [ReplicatedStorage]: https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage

## Creator Store <small>recommended</small> { #creator-store data-toc-label="Creator Store" }

1. Get the **Satchel** model from the [Creator Store].

    ![Creator Store](assets/creator-store.png){ width="100%" }

1. Open Roblox Studio and create a new place or open an existing place.

1. From the [View] tab, open the [Toolbox] and select the **Inventory** tab.

    ![View Tab Toolbox](https://prod.docsiteassets.roblox.com/assets/studio/general/View-Tab-Toolbox.png)

    ![Inventory Tab](https://prod.docsiteassets.roblox.com/assets/studio/toolbox/Inventory-Tab.png)

1. Locate the **Satchel** model and click it, or drag-and-drop it into the 3D view.

    ![Toolbox](assets/store-card.png)

1. In the [Explorer] window, move the **Satchel** model into [`ReplicatedStorage`][ReplicatedStorage].

  [Creator Store]: https://create.roblox.com/store/asset/13947506401
  [View]: https://create.roblox.com/docs/studio/view-tab
  [Toolbox]: https://create.roblox.com/docs/projects/assets/toolbox
  [Explorer]: https://create.roblox.com/docs/studio/explorer

## GitHub Releases

1. Download the `Satchel.rbxm` or `Satchel.rbxmx` model file from [GitHub Releases].

    !!! info

        Binary (`.rbxm`) and XML (`.rbxmx`) model files contain the exact same model. `.rbxm` is a smaller file size to download.

    ![GitHub Release](assets/github-releases.png)

1. Open Roblox Studio and create a new place or open an existing place.

1. In the [Explorer] window, insert **Satchel** into [`ReplicatedStorage`][ReplicatedStorage].

    ![Contextual menu](https://prod.docsiteassets.roblox.com/assets/studio/explorer/Context-Menu-Service.png){ width="50%" }

1. Select the **Satchel** model file you downloaded from GitHub.

  [GitHub Releases]: https://github.com/RyanLua/Satchel/releases

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
