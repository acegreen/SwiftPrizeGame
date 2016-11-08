# SwiftPrizeGame

![alt tag](https://cloud.githubusercontent.com/assets/10794609/20085018/0be816a2-a534-11e6-81b4-675fec14c146.png))

## Prerequisites
Language: Swift
OS Versions: iOS 9 or 10, Xcode 8
Expected time to complete: ~4 hours of coding time

## Summary
Create a simple game in which automated players move through a grid of cells searching for a prize placed randomly in one of the cells.

## Task
* Create a view with a 5x5 grid of cells (see example picture below).
* Place the prize on a random cell in the grid (but not in any of the corners).
* Spawn two players in different corners of the grid. The players will initially occupy one cell.
* When the game starts, each player should start searching the grid by moving to adjacent cells (not
diagonally). The players should move at a rate that allows game progress to be observed visually.
* As each player moves the grid should reflect where the player has been. Players cannot cross the trail
left by the other player. However, players can backtrack on their own trail or decline to move if the
player is unable to move to any other adjacent cell.
* If a player backtracks over its own trail, the cell it previously occupied should be cleared.
* When one of the players finds the prize, update the score and start a new game.
* Feel free to enhance the game as you like.
Submission guidelines
* We will accept and review partial solutions. If you submit a partial solution, please include a written explanation of your thought process and proposed method for getting the full solution working.
* A git repo is the preferred method for submitting the project. However, you can submit your project in whatever format is most convenient.
