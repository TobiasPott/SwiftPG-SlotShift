import SwiftUI

struct GameInfoView: View {
    @ObservedObject var game: GameHandle
    let gameSlot: Int
    
    var body: some View {
        
        if game.selectedMode != .none {
            UIPanel {
                
                VStack(alignment: .leading) {
                    Text("Slot \(Statics.getSlotId(game.slot))")
                        .font(Statics.calloutFont)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    if let gameBehaviour = game.getGameBehaviour(game.selectedMode) {
                        let score = gameBehaviour.score
                        Text("Turns  \t\(score.turns)")
                        Text("Merged \t\(score.merges)")
                        Text("History\t\(gameBehaviour.historyCount) (max: \(Statics.maxHistory))")
                    }
                }.frame(maxWidth: 240, alignment: .leading)
                    .font(Statics.captionFont)
            }
        }
        
    }
    
    
    
}
