import SwiftUI

struct AppMainView: View {
    
    @StateObject var game: GameHandle = GameHandle()
    @State var gameSlot: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > geometry.size.height
            
            ZStack {
                VStack {
                    VStack(spacing: 16.0) {
                        let title = TitleboardView(game: game)
                        let scoreboard = ScoreboardView(game: game) 
                        
                        Stack(layout: isWide ? .horizontal : .vertical, content: {
                            Group { 
                                Button(action: { withAnimation { game.tick = 1 } }, label: { title } ).foregroundStyle(.primary)
                                scoreboard.isHidden(game.mode == .none)
                            }
                        }, verticalAlignment: .bottom, horizontalAlignment: .center)
                        
                        if game.mode == .none { StartscreenView(game: game) } 
                        else { GameView(game: game) }
                        
                    }
                    .frame(maxWidth: 600.0, maxHeight: .infinity)
                    .padding(.horizontal)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, white: 0.85, opacity: 1.0))
                
                AppSettingsView(game: game)
                AppAboutView()
//                
//                UIPanel {
//                    AboutSheet(isOpen: .constant(true))
//                }.padding()
                
            }
        }
        .onAppear(perform: {
            /// load game from UserDefaults (only succeeds if present)
            game.load()
        })
        // handle termination event
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { output in
            // Code to run on will terminate
            //            print("App terminated!")
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { output in
            // Code to run on will terminate
            //            print("App became inactive!")
            game.save()
        })
        
    }
    
}
