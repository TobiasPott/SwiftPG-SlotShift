import SwiftUI

struct PlayfieldInput: View {
    // Members
    var game: GameHandle
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20.0)
            .foregroundStyle(Color(.sRGB, white: 1.0, opacity: 0.01))
        
            .squareFit()
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30): /* left */ game.nextTurn(.left)
                    case (0..., -30...30): /* right */ game.nextTurn(.right)
                    case (-30...30, ...0): /* up */ game.nextTurn(.up)
                    case (-30...30, 0...): /* down */ game.nextTurn(.down)
                    default: print("Drag gesture not clear.")
                    }
                }
            )
            .padding(-12)
        
    }
}
