import SwiftUI

struct TitleboardView: View {
    @ObservedObject var game: GameHandle
    
    var body: some View {
        VStack(spacing: 12.0) {
            UIPanel {
                Group{
                    HStack(alignment: .center) {
                        Image("SwiftPG-BlockShift-TitleIcon").resizable().aspectRatio(1.0, contentMode: .fit)
                            .shadowDrop(radius: 2.5, x: 0, y: 3.0)
                        Text("2048-like game development & learning project").fontWeight(.light)
                    }.frame(maxHeight: 128.0)
                    if game.tick <= 0 {
                        Text("Tap to start").fontWeight(.bold)
                            .frame(maxHeight: 16.0)
                    }
                }
            }
        }
    }
}
