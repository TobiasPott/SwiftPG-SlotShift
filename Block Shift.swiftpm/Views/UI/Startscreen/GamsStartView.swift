import SwiftUI

struct GameStartView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var gameMode: GameMode = .num2048_5by5
    
    var body: some View {
        UIPanel {
            HStack {
                ButtonStyled(title: "Load", action: {
                    print("Not implemented yet: Load")
                }, isSelected: false)
                .disabled(true)
                .frameMax(128, 48)
                
                ButtonStyled(title: "New Game", action: {
                    game.setMode(gameMode)
                    game.startGame(gameMode)
                })
                .frameMax(128, 48)
                
            }
        }
    }
}
