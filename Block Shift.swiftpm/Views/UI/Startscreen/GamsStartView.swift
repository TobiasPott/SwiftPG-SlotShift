import SwiftUI

struct GameStartView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var gameMode: GameMode = .num2048_5by5
    
    var body: some View {
        UIPanel {
            VStack {
                let canContinue = gameMode != .none && game.getGame(gameMode).historyCount > 0
                HStack {
                    ButtonStyled(title: "Continue", action: {
                        game.setMode(gameMode)
                    }, isSelected: canContinue)
                    .disabled(!canContinue)
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
}
