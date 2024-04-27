import SwiftUI

struct GameOfLifeView: View {
    @ObservedObject var game: Life
    let cellSize: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(0..<game.rows, id: \.self) { row in
                    HStack {
                        ForEach(0..<game.columns, id: \.self) { col in
                            Rectangle()
                                .fill(self.game.grid[row][col] ? Color.white : Color.black)
                                .frame(width:self.cellSize, height: self.cellSize)
                        }
                    }    
                }
            }
            .onAppear(perform: {
                let _ = self.game.setupGrid(rows: Int(geometry.size.height/self.cellSize), columns: Int(geometry.size.width/self.cellSize))
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    self.game.play()    
                }
            })
        }    
    }
}
