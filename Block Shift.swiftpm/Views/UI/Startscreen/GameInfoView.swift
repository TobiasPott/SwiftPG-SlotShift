import SwiftUI

struct GameInfoView: View {
    @ObservedObject var game: GameHandle
    let gameMode: GameMode
    let gameSlot: Int
    
    var body: some View {
        
        if gameMode != .none {
            UIPanel {
                VStack(alignment: .leading) {
                    Text("Slot \(game.slot)")
                    let gameBehaviour = game.games.getGame(gameMode, gameSlot)!
                    Text("Turns  \t\t\(gameBehaviour.turnCount)")
                    Text("Merged \t\t\(gameBehaviour.mergedCount)")
                    Text("History\t\t\(gameBehaviour.historyCount) (max: \(GameStatics.maxHistory))")
                }.frame(maxWidth: 240, alignment: .leading)
                    .font(Statics.captionFont)
            }
        }
        
    }
    
    
    
}
