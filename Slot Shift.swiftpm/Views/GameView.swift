import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameHandle;
    
    var body: some View {
        // Playfield block
        if let gameBehaviour = game.getGameBehaviour() {
            ZStack {
                Group { 
                    // number games
                    if game.getIs([.num2048_5by5, .num2048]), let tGame = gameBehaviour as? GameBase<SlotNumber> { PlayfieldView(matrix: tGame.getMatrix()) }
                    // color games
                    else if game.getIs([.colors]), let tGame = gameBehaviour as? GameBase<SlotRGB> { PlayfieldView(matrix: tGame.getMatrix()) }
                    
                }
                .padding(18.0)
                .squareFit()
                
                PlayfieldInput(game: game)
                
            }
            .padding(.bottom, 4.0)
            .backgroundPanel()
            .transition(.scale)
        }
    }
}
