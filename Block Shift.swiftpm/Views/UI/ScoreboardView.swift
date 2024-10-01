import SwiftUI

struct ScoreboardView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        let games: GameCollection = game.games
        let gameMode: GameMode = game.mode
        let gameSlot: Int = game.slot
        
        
        VStack() {
            let vSpacing: CGFloat = 6.0
            HStack() {
                HStack {
                    VStack(spacing: vSpacing) { Image(systemName: "arrow.circlepath")
                        Text("\(games.getTurnCount(gameMode, gameSlot))")
                    }
                    
                    //                    Spacer()
                    //                    VStack(spacing: vSpacing) { Image(systemName: "clock.arrow.circlepath"); Text("\(games.getHistoryCount(gameMode, gameSlot))") }
//                                        Spacer()
                    VStack(spacing: vSpacing) { Image(systemName: "arrow.triangle.merge"); Text("\(games.getMergedCount(gameMode, gameSlot))") }
                }
                .padding(.horizontal)
                MenuView(game: game)
                // ToDo: Debug game handle tick to update UI (may be obsolete, to be checked later)
                //                Text("\(games.turnCount)").font(.system(size: 10).monospaced())
            }
            .padding(12.0)        
            let noneEmpty = !games.anyEmpty(gameMode, gameSlot)
            if noneEmpty {
                Text("Board Full")
            }
        }.monospaced(size: 16)
            .padding(8.0)
            .backgroundPanel()
        
    }
}
