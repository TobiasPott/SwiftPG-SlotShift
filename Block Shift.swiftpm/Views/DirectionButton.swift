import SwiftUI

struct DirectionalButton: View {
    var move: GameMove
    var game: GameBehaviour
    
    var body: some View {
        if (move != .none) {
            Button("", systemImage: "arrowshape.\(move).fill", action: {
                game.nextTurn(move)
            })                    
            .frame(width: 64, height: 64)
        } else {
            Button("", systemImage: "square.fill", action: {
                game.nextTurn(move)
            })
            .frame(width: 64, height: 64)            
        }
    }
}
