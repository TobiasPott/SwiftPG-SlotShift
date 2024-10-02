import SwiftUI

struct MenuView: View {
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        
        Menu { 
            // New game button
            Button(action: { withAnimation { game.nextTurn(.SY_newGame) } }, 
                   label: { Label("New Game", systemImage: "plus") })
            Divider()
            Button(action: { withAnimation { game.revert() } }, 
                   label: { Label("Revert Turn", systemImage: "arrow.trianglehead.counterclockwise.rotate.90") })
            Divider()
            Button(action: { withAnimation { game.quitGame() } }, 
                   label: { Label("Quit Game", systemImage: "minus") })
            
        } label: { 
            Label("Menu", systemImage: "gearshape")
        }
        .backgroundButton()
        .frameMax(96, 48)
    }
}
