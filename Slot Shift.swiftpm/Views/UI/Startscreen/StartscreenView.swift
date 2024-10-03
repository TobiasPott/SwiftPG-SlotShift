import SwiftUI

struct StartscreenView: View {
    
    @ObservedObject var game: GameHandle
    @State private var selectedGameMode: GameMode = .num2048_5by5
    
    var body: some View {
        // check if game was ticked once (first tick is assumed to be startscreen tap)
        if game.tick > 0 {
            VStack(spacing: 18) {
                //            GameTitleView(gameMode: selectedGameMode)
                
                GameSlotView(game: game)
                GameInfoView(game: game, gameMode: selectedGameMode, gameSlot: game.slot)
                GameStartView(game: game)
            }
            .padding(.vertical, 6.0)
        }
    }
}
