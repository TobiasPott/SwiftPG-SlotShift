import SwiftUI

struct PlayfieldSlotView<S: Mergable>: View {
    var entry: S;
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            entry.asView.shadow(radius: 2.5)
            
            if entry.Mode != .clear && entry is SlotRGB {
                let firstColor = Color(.sRGB, white: 0.0, opacity: 1.0)
                let secondColor = Color(.sRGB, white: 1.0, opacity: 0.5)
                
                Text("\(entry.Mode)")
                    .foregroundStyle(firstColor)
                    .padding(6.0)
                    .monospaced(size: 10)
                    .background(secondColor)
                    .roundedMask(12)
                    .padding(4.0)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
        .frameInfinity()
    }
}
