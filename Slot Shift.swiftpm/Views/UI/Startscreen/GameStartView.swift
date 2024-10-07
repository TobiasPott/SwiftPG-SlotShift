import SwiftUI

struct GameStartView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        UIPanel {
            VStack {
                let canContinue = game.selectedMode != .none && game.getGameBehaviour(game.selectedMode)!.historyCount > 0
                HStack {
                    
                    Group {
                        ButtonStyled(title: "New Game", action: {
                            game.setMode(game.selectedMode)
                            game.startGame(game.selectedMode)
                        })
                        ButtonStyled(title: "Continue", action: {
                            game.setMode(game.selectedMode)
                        }, isSelected: canContinue, color: .green)
                        .disabled(!canContinue)
                    }
                    .frameMax(128, 48)
                    
                }
            }
        }
    }
}
