import SwiftUI

struct GameSlotView: View {
    @ObservedObject var game: GameHandle
    
    var body: some View {
        UIPanel {
            VStack(alignment: .leading) {
                Text("Game slot").font(Statics.calloutFont).fontWeight(.bold)
                
                let spacing: CGFloat = 6.0
                let item: GridItem = .init(.fixed(48.0), spacing: spacing, alignment: .center)
                let gridLayout: [GridItem] = [item, item]
                LazyVGrid(columns: gridLayout, spacing: spacing) {
                    ForEach(0..<4, id: \.self) { i in
                        ButtonStyled(title: "\(Statics.getSlotId(i))", action: { 
                            game.setSlot(i)
                        }, isSelected: game.slot == i, withAnim: false)
                        .aspectRatio(1.0, contentMode: .fit)
                        //                        .frame(maxWidth: 48.0)
                    }
                }
            }
        }
        
    }
}
