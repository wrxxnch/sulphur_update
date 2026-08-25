<img width="861" height="529" alt="screenshot_20260825_173627" src="https://github.com/user-attachments/assets/f5070f6d-1178-470c-abe0-1df3e98d1d5c" />
<img width="530" height="470" alt="image" src="https://github.com/user-attachments/assets/3416a7a8-5615-4663-8ee1-b3eafe50cf26" />

# Sulphur Update

Mod for **BetterCraft**, the Mineclonia-based game for Luanti. It adds a volcanic and chemical layer to the underground, with sulfur, cinnabar, geysers, sulfurous smoke, and a slime whose behavior changes depending on the block placed inside it.

## Installation

Copy the `sulphur_update` folder to `games/bettercraft/mods/` inside your BetterCraft installation. Since this mod uses the `mcl_core`, `mcl_mobs`, and `mcl_potions` APIs, it must be enabled in a BetterCraft world, not in a world created with vanilla Minetest Game.

## Content

This version uses the sprites of [Sulfur](https://minecraft.wiki/w/Sulfur), [Cinnabar](https://minecraft.wiki/w/Cinnabar), [Sulfur Cube](https://minecraft.wiki/w/Sulfur_Cube), [Bucket of Sulfur Cube](https://minecraft.wiki/w/Bucket_of_Sulfur_Cube), and [Music Disc Bounce](https://minecraft.wiki/w/Music_Disc_Bounce) as reference. The texture files for the requested assets are included in the package. **Slabs, stairs, and walls were deliberately left out at this stage and will be added later.**

## Sulfur Spike OBJ/MTL Models

The nodes use the exact names of the provided models. Place the OBJ/MTL pairs in the mod's `models/` folder without renaming the files. The registered models are `sulfur_spike.obj`/`.mtl`, `sulfur_spike_down_base.obj`/`.mtl`, `sulfur_spike_down_frustum.obj`/`.mtl`, `sulfur_spike_down_middle.obj`/`.mtl`, `sulfur_spike_down_tip_merge.obj`/`.mtl`, `sulfur_spike_down_tip.obj`/`.mtl`, `sulfur_spike_up_base.obj`/`.mtl`, `sulfur_spike_up_frustum.obj`/`.mtl`, `sulfur_spike_up_middle.obj`/`.mtl`, `sulfur_spike_up_tip_merge.obj`/`.mtl`, and `sulfur_spike_up_tip.obj`/`.mtl`. Each OBJ file must keep its `mtllib` reference pointing to the matching MTL file.

| Content | Behavior |
|---|---|
| Sulfur block | Yellow building block and ingredient for bricks. |
| Sulfur ore | Underground generation in stone and deepslate; drops sulfur dust. |
| Sulfur stalactite | Non-walkable decorative node, suited for caves. |
| Cinnabar | Red building block, with wiki-based texture. |
| Chiseled cinnabar | Chiseled variant of cinnabar. |
| Polished cinnabar | Polished variant of cinnabar. |
| Cinnabar bricks | Decorative variant of cinnabar. |
| Potent sulfur | Concentrated variant of sulfur. |
| Sulfur | Yellow building block, with wiki-based texture. |
| Chiseled sulfur | Chiseled variant of sulfur. |
| Polished sulfur | Polished variant of sulfur. |
| Sulfur bricks | Decorative variant of sulfur. |
| Sulfur spike | Pointed decorative node. |
| Sulfur geyser | Periodically emits hot particles, faint light, and sound pulses. |
| Sulfur smoke over water | Must sit above a water source; the area periodically causes nausea. |
| Sulfur cube | Can be spawned via the Spawn Egg, receive blocks with a right-click, and be collected into a bucket. |
| Bucket of Sulfur Cube | Stores and repositions a large sulfur cube. |
| Music Disc Bounce | Disc integrated into the jukebox; falls back to the base game's available sound record when the original audio is not present. |
| Sulfur Cube Spawn Egg | Spawn egg with wiki sprite. |

## Mutable Slime

Hold a block and right-click the **Sulfur Slime**. The block is consumed, except in creative mode, and the slime displays the name of the stored material.

| Inserted material | Applied effect |
|---|---|
| Wood | Lower speed, lower gravity, and bouncier jumps, like a plastic ball. |
| Stone or block with the pickaxe group | Higher gravity, lower speed, and reduced jump; the slime becomes heavy. |
| Ice or block with the `ice` group | Much higher speed and slippery/fast movement. |
| Sulfur | Default behavior, keeping the balanced profile. |

Classification uses node groups, so any wood, stone, or ice blocks compatible with Mineclonia also work, not just the blocks added by this mod.

## Quick Test

After enabling the mod, use the creative inventory or the base game's grant commands to obtain the items. To test the slime, get the `sulphur_update:sulphur_slime_spawn_egg` spawn egg, place a geyser, and watch the particle pulses. To test the smoke, place `sulphur_update:sulphur_smoke` directly above a water source and stay nearby for a few seconds.

## Compatibility

The implementation was written for the `wrxxnch/luanti-bettercraft` tree and uses the node naming and Mineclonia APIs present in that base. Lua syntax was validated before packaging; in-game validation should be done on a test copy of the world.

## License

The new code in this mod is distributed under MIT. The BetterCraft/Mineclonia base and its assets remain subject to the respective projects' own licenses.
