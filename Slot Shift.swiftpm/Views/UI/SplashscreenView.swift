import SwiftUI

struct SplashscreenView: View {
    @ObservedObject var game: GameHandle
    let isWide: Bool
    
    var body: some View {
        let title = TitleboardView(game: game)
        let scoreboard = ScoreboardView(game: game) 
        
        Stack(layout: isWide ? .horizontal : .vertical, content: {
            Group { 
                Button(action: { withAnimation { game.tick = 1 } }, label: { title } ).foregroundStyle(.primary)
                scoreboard.isHidden(game.mode == .none)
            }
        }, verticalAlignment: .bottom, horizontalAlignment: .center)
    }
}
