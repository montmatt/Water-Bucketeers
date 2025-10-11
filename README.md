This is a repository of a custom project submission for Prof. Gillian Smith's WPI CS/IMGD 4100 class "Artificial Intelligence for Interactive Media and Games."
The purpose of of this project is for our own educational purposes only and not meant for commercial use. However, feel free to explore our project!

<h3 id="features">Overview</h3>

------
This project explores the use of procedural generation for a 2D game concept about extinguishing houses on fire. Currently, the player controls a helicopter game object
to put out houses on fires using buckets of water. Random terrain generates with each run the player makes, with different tiles for biomes using GameMaker’s tilemap feature.
An aerial view allows the player to see the game objects. Future implementation would have the player control the helicopter to collect water with their bucket,
to extinguish those random fires while navigating the various biomes.

The game makes use of Perlin Noise to generate the terrain to produce unique yet recognizable landscapes for each run.
For art, we have utilized GameMaker's built-in art tools to create the sprites and objects.

<h3 id="features">Group Members</h3>

------
- Matthew Montero
- Richie DeBlasio
- Abhi Chillara

<h3 id="features">External Sources</h3>

------
We didn't receive outside help for our group. However, we referenced external sources to aid in our development process:
- https://youtu.be/nBCDzE9MDbk?si=YJw2nmgnumXLu8TP (for learning how to use GameMaker)
- https://en.wikipedia.org/wiki/Perlin_noise (for learning about Perlin Noise)
- https://youtu.be/ms1wczeXAT0?si=yzllgQoyqTJ2NuMQ (for initial understanding about Perlin Noise in GameMaker)
- https://youtu.be/vkHYpuo29YI?si=KttZ9oihF5G4cwfQ (for specific implementation of Perlin Noise in GameMaker)
- https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/Tile_Map_Layers/Tile_Map_Layers.htm (for tilemap implementation)

<h3 id="use">How To Use</h3>

------

*Note: Currently, features of this project are yet to be merged into a single main branch. Therefore, using our repo to experience everything requires running several branches independently, which is detailed at Step 3 below.*

1. Install GameMaker: https://gamemaker.io/en/download.
2. Download this repository.
3. Depending on what features to explore, if you want to:
   - See current procedural terrain generation with tiles:
     - Go to [Abhi's first branch](https://github.com/montmatt/Water-Bucketeers/tree/Abhi-working-branch).
     - Run the [`GameMaker Project`](https://github.com/montmatt/Water-Bucketeers/blob/a3a70b7a92853737ffc6d770344692f59446892f/Water%20Bucketeers.yyp) on GameMaker.
     - Press the "Play" button (or F5 key).
       - *You can generate different terrain in a single play session by pressing the space bar on your keyboard.*
   - See previously "good" procedural terrain generation:
     - Go to [Matt's branch](https://github.com/montmatt/Water-Bucketeers/tree/Matt's-Branch).
     - Run the [`GameMaker Project`](https://github.com/montmatt/Water-Bucketeers/blob/57c3eb6236f7f52cc2d3da4782f555491a8334d8/Water%20Bucketeers.yyp) on GameMaker.
     - Press the "Play" button (or F5 key).
       - *You can generate different terrain in a single play session by pressing the space bar on your keyboard.*
   - See current game mechanics and implementation:
     - Go to [Richie's branch](https://github.com/montmatt/Water-Bucketeers/tree/Richie's-Branch).
     - Run the [`GameMaker Project`](https://github.com/montmatt/Water-Bucketeers/blob/91a7ecb35dce1f0156ab7dd27b3950bbf4e03d99/Water%20Bucketeers.yyp) on GameMaker.
     - Press the "Play" button (or F5 key).
       - *The terrain is fixed, but you can move the player object around using either WASD or arrow keys.*
   - See all the art for the game:
     - Go to [Abhi's second branch](https://github.com/montmatt/Water-Bucketeers/tree/Abhi's-Branch).
     - Run the [`GameMaker Project`](https://github.com/montmatt/Water-Bucketeers/blob/c5c5a1ac01c3f8bf2aa7f7514c3f1d8ee125a31d/Water%20Bucketeers.yyp) on GameMaker.
     - Navigate to the "[sprites](https://github.com/montmatt/Water-Bucketeers/tree/c5c5a1ac01c3f8bf2aa7f7514c3f1d8ee125a31d/sprites)" folder and double-click on it for a drop-down.
     - Double-click on any of the sprite names for an expanded view within GameMaker.
