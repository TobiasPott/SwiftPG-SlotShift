import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameHandle;
    
    var body: some View {
        // Playfield block
        if let gameBehaviour = game.getGameBehaviour() {
            ZStack {
                // number games
                if game.getIs([.num2048_5by5, .num2048]), let nGame = gameBehaviour as? GameBase<Slot2048> { PlayfieldView(matrix: nGame.getMatrix()) }
                // color games
                if game.getIs([.colors]), let cGame = gameBehaviour as? GameBase<SlotRGB> { PlayfieldView(matrix: cGame.getMatrix()) }
                
                PlayfieldInput(game: game)
                
            }
            .squareFit()
            .backgroundPanel()
            .transition(.scale)
        }
    }
}
