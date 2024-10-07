import SwiftUI

struct StartscreenView: View {
    
    @ObservedObject var game: GameHandle
    let isWide: Bool
    
    var body: some View {
        // check if game was ticked once (first tick is assumed to be startscreen tap)
        if game.tick > 0 {

                Grid(alignment: .trailing, horizontalSpacing: 0, verticalSpacing: 18, content: {
                    GridRow {
                        VStack(alignment: .leading, spacing: 18) {
                            GameModeView(mode: $game.selectedMode)
                            
                            HStack(alignment: .bottom) {
                                GameSlotView(game: game)
                                GameInfoView(game: game, gameSlot: game.slot)
                            }
//                            .background(.blue)
                        }
                    }
                    GridRow { GameStartView(game: game) }
//                        .background(.red)
                })
            
        }
    }
}
