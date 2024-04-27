import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GameOfLifeView(game: Life())
        }
    }
}
