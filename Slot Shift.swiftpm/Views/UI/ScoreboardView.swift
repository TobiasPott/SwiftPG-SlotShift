import SwiftUI

struct ScoreboardView: View {
    
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        
        if let gameBehaviour = game.getGameBehaviour() {
            let score = gameBehaviour.score
            let turnsIcon = Image(systemName: "arrow.circlepath")
            let mergesIcon = Image(systemName: "arrow.triangle.merge")
            
            UIPanel {
                VStack() {
                    HStack() {
                        ButtonStyled(title: "\(Statics.getSlotId(game.slot))")
                            .frameMax(32, 32)
                            .padding(.leading, 4)
                        Spacer()
                        VScoreView(value: score.turns, icon: turnsIcon)
                        Spacer()
                        VScoreView(value: score.merges, icon: mergesIcon)
                            .padding(.trailing)
                        MenuView(game: game)
                    }        
                    let noneEmpty = !gameBehaviour.anyEmpty
                    if noneEmpty {
                        Text("Board Full")
                    }
                }.monospaced(size: 16)
                    .transition(.scale)
            }
        }
    }
}

struct VScoreView: View {
    let value: Int
    var icon: Image = Image(systemName: "arrow.circlepath")
    
    var body: some View {
        let vSpacing: CGFloat = 6.0
        VStack(spacing: vSpacing) { 
            icon
            Text("\(value)") 
        }
    }
}
