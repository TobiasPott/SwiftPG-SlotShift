import SwiftUI

struct GameSlotView: View {
    @ObservedObject var game: GameHandle
    
    var body: some View {
        UIPanel {
            VStack(alignment: .leading) {
                Text("Game slot").font(Statics.calloutFont).fontWeight(.bold)
                
                let spacing: CGFloat = 6.0
                // let item: GridItem = .init(.fixed(48.0), spacing: spacing, alignment: .leading)
                // let gridLayout: [GridItem] = [item, item]
                
                Grid(alignment: .leading, horizontalSpacing: spacing, verticalSpacing: spacing, content: {
                    ForEach(0..<2, id: \.self) { r in
                        GridRow {
                            ForEach(0..<2, id: \.self) { i in
                                let index = r*2 + i
                                ButtonStyled(title: "\(Statics.getSlotId(index))", action: { game.setSlot(index) }, isSelected: game.slot == index, withAnim: false)
                                    .monospacedScaledToFit()
                                    .aspectRatio(1.0, contentMode: .fill)
                                    .frame(maxWidth: 48, maxHeight: 48.0)
                            }
                        }
                    }
                })
                
            }
        }
        
    }
}
