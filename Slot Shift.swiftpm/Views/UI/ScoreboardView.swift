import SwiftUI

struct ScoreboardView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        
        if let gameBehaviour = game.getGameBehaviour() {
            
            VStack() {
                let vSpacing: CGFloat = 6.0
                HStack() {
                    HStack {
                        VStack(spacing: vSpacing) { Image(systemName: "arrow.circlepath")
                            Text("\(gameBehaviour.turnCount)") }
                        Spacer()
                        VStack(spacing: vSpacing) { Image(systemName: "arrow.triangle.merge"); Text("\(gameBehaviour.mergedCount)") }
                    }
                    .padding(.horizontal)                
                    .padding(.horizontal)
                    MenuView(game: game)
                }
                .padding(12.0)        
                let noneEmpty = !gameBehaviour.anyEmpty
                if noneEmpty {
                    Text("Board Full")
                }
            }.monospaced(size: 16)
                .padding(8.0)
                .backgroundPanel()
                .transition(.scale)
        }
    }
}
