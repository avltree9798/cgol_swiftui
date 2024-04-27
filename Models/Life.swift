import SwiftUI

class Life: ObservableObject {
    @Published var grid: [[Bool]]
    var rows: Int
    var columns: Int
    init() {
        self.rows = 0
        self.columns = 0
        self.grid = []
    }
    
    func setupGrid(rows: Int, columns: Int) -> Self {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: Array(repeating: false, count: columns), count: rows)
        self.setupGosperGliderGun()
        return self
    }
    
    func setupGosperGliderGun() {
        let pattern: [(Int, Int)] = [
            (1, 25),
            (2, 23), (2, 25),
            (3, 13), (3, 14), (3, 21), (3, 22), (3, 35), (3, 36),
            (4, 12), (4, 16), (4, 21), (4, 22), (4, 35), (4, 36),
            (5, 1), (5, 2), (5, 11), (5, 17), (5, 21), (5, 22),
            (6, 1), (6, 2), (6, 11), (6, 15), (6, 17), (6, 18), (6, 23), (6, 25),
            (7, 11), (7, 17), (7, 25),
            (8, 12), (8, 16),
            (9, 13), (9, 14)
        ]
        for (x, y) in pattern {
            if x < rows && y < columns {
                grid[x][y] = true
            }
        }
    }
    
    func countNeighbours(row: Int, col: Int) -> Int {
        var neighbours = 0
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 && j == 0 {
                    continue
                }
                let newRow = row + i
                let newCol = col + j
                if newRow >= 0 && newRow < self.rows && newCol >= 0 && newCol < self.columns && grid[newRow][newCol] {
                    neighbours += 1
                }
            }
        }
        return neighbours
    }
    
    func play() {
        var newGrid = grid
        for row in 0..<self.rows {
            for col in 0..<self.columns {
                let neighbours = self.countNeighbours(row: row, col: col)
                // Over-populated / Under-populated
                if neighbours < 2 || neighbours > 3 {
                    newGrid[row][col] = false
                    continue
                }
                if neighbours == 3 {
                    newGrid[row][col] = true
                }
                
            }
        }
        grid = newGrid
    }
}
