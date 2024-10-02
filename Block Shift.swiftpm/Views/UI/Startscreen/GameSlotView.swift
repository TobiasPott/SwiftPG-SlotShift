import SwiftUI

struct GameSlotView: View {
    @Binding var slot: Int
    
    
    var body: some View {
        UIPanel {
            VStack {
                HStack { Text("Select a game slot").font(Statics.titleFont) }
                HStack(spacing: 16) {
                    ForEach(0..<4) { i in
                        ButtonStyled(title: "\(i)", action: { 
                            slot = i
                        }, isSelected: slot == i, withAnim: false)
                        .frame(maxWidth: 48)
                    }
                }
                .frame(maxHeight: 48.0)
            }
        }
        
    }
}
