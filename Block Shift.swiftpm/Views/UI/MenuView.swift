import SwiftUI

struct MenuView: View {
    @ObservedObject var game: GameHandle = GameHandle()
    
    var body: some View {
        let binding = Binding( get: { game.mode }, set: { game.setMode($0) } )
        
        Menu { 
            // New game button
            Button(action: { game.nextTurn(.SY_newGame) }, 
                   label: { Label("New Game", systemImage: "plus") })
            Divider()
            Button(action: { game.revert() }, 
                   label: { Label("Revert Turn", systemImage: "arrow.trianglehead.counterclockwise.rotate.90") })
            Divider()
            Button(action: {
                withAnimation { 
                    game.setMode(.none)
                }
            }, label: { Label("Quit Game", systemImage: "minus") })
            
        } label: { 
            Label("Menu", systemImage: "gearshape")
        }                
        .backgroundButtonNEW()
        .frameMax(96, 48)
    }
}
