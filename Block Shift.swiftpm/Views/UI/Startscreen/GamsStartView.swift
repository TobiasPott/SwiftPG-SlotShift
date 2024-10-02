import SwiftUI

struct GameStartView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var gameMode: GameMode = .num2048_5by5
    
    var body: some View {
        UIPanel {
            VStack {
                let canContinue = gameMode != .none && game.getGame(gameMode).historyCount > 0
                if gameMode != .none {
                    UIPanel {
                        VStack(alignment: .leading) {
                            let gameBehaviour = game.getGame(gameMode)
                            Text("Turns  \t\(gameBehaviour.turnCount)")
                            Text("Merged \t\(gameBehaviour.mergedCount)")
                            Text("History\t\(gameBehaviour.historyCount) (max: \(GameStatics.maxHistory))")
                        }.frame(maxWidth: 320, alignment: .leading)
                    }.padding(.bottom)
                }
                
                HStack {
                    ButtonStyled(title: "Continue", action: {
                        game.setMode(gameMode)
                    }, isSelected: canContinue)
//                    .disabled(true)
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
