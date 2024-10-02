import SwiftUI

struct AppSettingsView: View {
    
    @StateObject var game: GameHandle = GameHandle()
    
    @State private var showHeader: Bool = false
    @State private var showFooter: Bool = false
    
    var body: some View {
        let gearIcon = Image(systemName: "gearshape.circle").resizable().aspectRatio(1.0, contentMode: .fill)
        
        ///Remark: Header block
        ZStack() {
            if showHeader || showFooter {
                Button(action: { withAnimation {
                    showHeader = false
                    showFooter = false
                } }, label: { Rectangle().foregroundStyle(.black).opacity(0.25) })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            ///-> HEADER BLOCK
            HStack() {
                VStack(alignment: .trailing) {
                    Button(action: { withAnimation { showHeader.toggle() } }, 
                           label: { gearIcon })
                    .backgroundButton().frameMax(48, 48)
                    
                    if showHeader {
                        UIPanel {
                            HStack() {
                                Text("Test")
                            }.frame(maxWidth: 220.0, alignment: .trailing)
                        }.background(.brown.opacity(0.5))
                            .transition(.move(edge: .top))
                    }
                }
            }
            .padding([.leading, .top, .trailing])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            ///-> FOOTER BLOCK
            HStack() {
                VStack(alignment: .trailing) {
                    Button(action: { showFooter.toggle() }, 
                           label: { Image(systemName: "gearshape.circle").resizable().aspectRatio(1.0, contentMode: .fill) })
                    .backgroundButton().frameMax(48, 48)
                }
                // Continue: insert if showFooter { } and insert views into it
            }
            .padding([.leading, .bottom, .trailing])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .isHidden(true)
            
        }
    }
    
}
