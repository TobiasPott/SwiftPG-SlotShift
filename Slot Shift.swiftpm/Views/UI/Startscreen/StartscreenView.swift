import SwiftUI

struct StartscreenView: View {
    
    @ObservedObject var game: GameHandle
    
    var body: some View {
        // check if game was ticked once (first tick is assumed to be startscreen tap)
        if game.tick > 0 {
            VStack(spacing: 18) {
                HStack(alignment: .top) {
                    GameSlotView(game: game)
                    GameInfoView(game: game, gameSlot: game.slot)
                }
                GameStartView(game: game)
            }
            .padding(.vertical, 6.0)
        }
    }
}
