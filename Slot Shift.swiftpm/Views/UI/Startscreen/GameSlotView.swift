import SwiftUI

struct GameSlotView: View {
    @ObservedObject var game: GameHandle
    
    var body: some View {
        UIPanel {
            VStack {
                HStack { Text("Select a game slot").font(Statics.titleFont) }
                HStack(spacing: 16) {
                    ForEach(0..<4) { i in
                        ButtonStyled(title: "\(Statics.getSlotId(i))", action: { 
                            game.setSlot(i)
                        }, isSelected: game.slot == i, withAnim: false)
                        .aspectRatio(1.0, contentMode: .fill)
                        .frame(maxWidth: 48.0)
                    }
                }
                .frame(maxHeight: 48.0)
            }
        }
        
    }
}
