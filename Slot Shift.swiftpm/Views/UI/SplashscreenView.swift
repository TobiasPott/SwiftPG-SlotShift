import SwiftUI

struct SplashscreenView: View {
    @ObservedObject var game: GameHandle
    let isWide: Bool
    
    var body: some View {
        let title = TitleboardView(game: game)
        let scoreboard = ScoreboardView(game: game) 
        
        let stack = Stack(layout: isWide ? .horizontal : .vertical, content: {
            Button(action: { withAnimation { game.tick = 1 } }, label: { title } )
                .foregroundStyle(.primary)
            scoreboard.isHidden(game.mode == .none, remove: false)
        }, verticalAlignment: .bottom, horizontalAlignment: .center)
        stack
            .padding(.top, game.tick == 0 ? 160.0 : 0.0)
            .transition(.slide)
    }
}
