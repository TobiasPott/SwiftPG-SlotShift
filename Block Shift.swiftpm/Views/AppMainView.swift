import SwiftUI

struct AppMainView: View {

    @StateObject var game: GameHandle = GameHandle()
    @State var gameSlot: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > geometry.size.height
            
            VStack {
                
                
                HStack() {
                    Spacer()
                    Image(systemName: "questionmark.circle.fill")
                }.padding([.leading, .top, .trailing])
                
                VStack(spacing: 16.0) {
                    let title = TitleboardView()
                    let scoreboard = ScoreboardView(game: game) 
                    if isWide {
                        HStack(alignment: .bottom) { 
                            title
                            if game.mode != .none { scoreboard }
                        }
                    } else {
                        title
                        if game.mode != .none { scoreboard }
                    }             
                    
                    if game.mode == .none { StartscreenView(game: game) } 
                    else { GameView(game: game) }
                    
                }
                .frame(maxWidth: 600.0, maxHeight: .infinity)
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "questionmark.circle.fill.ar")
                    Spacer()
                }.padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity)
            .background(Color(.sRGB, white: 0.85, opacity: 1.0))
        }
    }
}
