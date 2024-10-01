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
                   label: { Label("Revert Turn", systemImage: "circle") })
            // Mode picker
//
//            Picker(selection: binding, label: Text("Mode")) {
//                Label("2048 (5x5)", systemImage: "n.square.fill").tag(GameMode.num2048_5by5)
//                Label("2048", systemImage: "n.square.fill").tag(GameMode.num2048)
//                Label("Colors", systemImage: "c.square.fill").tag(GameMode.colors)
//            }
//            Divider()
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
