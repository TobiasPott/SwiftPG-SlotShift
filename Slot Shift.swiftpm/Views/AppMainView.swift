import SwiftUI

struct AppMainView: View {
    
    @StateObject var game: GameHandle = GameHandle()
    @State var gameSlot: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > geometry.size.height
            
            ZStack(alignment: .top) {
                // background source code display
                SourceCodeView(sourceCode: game.mode == .none ? Texts.source_appmainview : Texts.source_gameview)
                // splash, startscreen and game view depending on game state
                VStack(spacing: 16.0) {
                    SplashscreenView(game: game, isWide: isWide)
                    if game.mode == .none { StartscreenView(game: game, isWide: isWide) } 
                    else { GameView(game: game) }
                }
                .frame(maxWidth: 720.0)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal)
                .padding(.vertical)                
                .padding(.top, 64.0)
                
                // 'overlay/popover' settings and about views
                AppSettingsView(game: game)
                AppAboutView()
            }
        }
        .onAppear(perform: {
            /// load game from UserDefaults (only succeeds if present)
            game.load()
        })
        // handle termination event
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), 
                   perform: { output in /* Code to run on will terminate */ })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), 
                   perform: { output in /* Code to run on will terminate */ game.save() })
        
    }
}
