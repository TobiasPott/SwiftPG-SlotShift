import SwiftUI

struct StartscreenView: View {
    
    @ObservedObject var game: GameHandle
    @State private var selectedGameMode: GameMode = .num2048_5by5
    
    var body: some View {
        VStack(spacing: 18) {
//            GameTitleView(gameMode: selectedGameMode)
            
            GameSlotView(game: game)
            GameInfoView(game: game, gameMode: selectedGameMode, gameSlot: game.slot)
            GameStartView(game: game)
        }
        .padding(.vertical, 6.0)
        
    }
}
