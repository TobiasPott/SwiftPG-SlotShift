import SwiftUI

struct GameTitleView: View {
    
    var gameMode: GameMode = .num2048_5by5
    
    var body: some View {
        UIPanel {
            HStack {
                Text(GameStatics.getName(gameMode)).font(Statics.titleFont)
                    .padding(.top, 4)
            }
        }
    }
}
