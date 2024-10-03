import SwiftUI

struct GameSlotView: View {
    @ObservedObject var game: GameHandle
    
    static private let slotIds: [String] = ["I", "II", "III", "IV"]
    
    var body: some View {
        UIPanel {
            VStack {
                HStack { Text("Select a game slot").font(Statics.titleFont) }
                HStack(spacing: 16) {
                    ForEach(0..<4) { i in
                        ButtonStyled(title: "\(GameSlotView.slotIds[i])", action: { 
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
