# Animation of Life
This project was a class assignment to write a script animating and simulating the game of life. On a 2D grid, cells are either alive or dead. after each iteration, cells are evaluated based on the following rules:

- Any live cell with fewer than two live neighbors dies [under-population]
- Any live cell with two or three live neighbors lives on to the next generation
- Any live cell with more than three live neighbors dies [over-population]
- Any dead cell with exactly three live neighbors becomes a live cell [reproduction]

The common method for edge checks were complex nested if statements, instead I used a larger matrix than the starting grid where the edges were the 'neighbors' from the other side.
