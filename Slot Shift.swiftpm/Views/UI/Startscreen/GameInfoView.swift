import SwiftUI

struct GameInfoView: View {
    @ObservedObject var game: GameHandle
    let gameMode: GameMode
    let gameSlot: Int
    
    var body: some View {
        
        if gameMode != .none {
            UIPanel {
                VStack(alignment: .leading) {
                    Text("Slot \(game.slot)").fontWeight(.bold)
                    if let gameBehaviour = game.getGameBehaviour(gameMode) {
                        let score = gameBehaviour.score
                        Text("Turns  \t\t\(score.turns)")
                        Text("Merged \t\t\(score.merges)")
                        Text("History\t\t\(gameBehaviour.historyCount) (max: \(Statics.maxHistory))")
                }
                }.frame(maxWidth: 240, alignment: .leading)
                    .font(Statics.calloutFont)
            }
        }
        
    }
    
    
    
}
