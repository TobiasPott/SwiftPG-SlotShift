import SwiftUI

struct GameView: View {
    @ObservedObject var game: GameHandle;
    
    var body: some View {    
        
        UIPanel {
            Text("Slot: \(game.slot) \(game.tick)")
        }
        // Playfield block
        ZStack {
            Group { 
                switch game.mode {
                case .num2048_5by5: PlayfieldView(matrix: game.games.games2048_5by5[game.slot].matrix)
                case .num2048: PlayfieldView(matrix: game.games.games2048[game.slot].matrix)
                case .colors: PlayfieldView(matrix: game.games.gamesColors[game.slot].matrix)
                case .none: EmptyView()
                }
            }
            .padding(18.0)
            .squareFit()
            
            PlayfieldInput(game: game)
            
        }
        .padding(.bottom, 4.0)
        .backgroundPanel()
        //        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
        .transition(.scale)
    }
}
