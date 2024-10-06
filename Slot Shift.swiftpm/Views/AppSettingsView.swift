import SwiftUI

struct AppSettingsView: View {
    
    @StateObject var game: GameHandle = GameHandle()
    
    @State private var showHeader: Bool = false
    @State private var showFooter: Bool = false
    
    func hideAll() { showHeader = false; showFooter = false; }
    
    var body: some View {
        let icon = Image(systemName: "gearshape.fill").resizable().aspectRatio(1.0, contentMode: .fill)
        ZStack() {
            if showHeader || showFooter {
                Button(action: { withAnimation { hideAll() } }, label: { Rectangle().foregroundStyle(.black).opacity(0.25) })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            ///-> HEADER BLOCK
            HStack() {
                VStack(alignment: .trailing) {
                    Button(action: { withAnimation { showHeader.toggle() } }, 
                           label: { icon })
                    .backgroundButton().frameMax(48, 48)
                    
                    if showHeader {
                        UIPanel {
                            VStack(alignment: .leading, spacing: 16.0) {
                                
                                Text("Change Mode")
                                Group {
                                    // ToDo: add function to start/continue game if mode is set
                                    ButtonStyled(title: "2048 (5 x 5)", action: { game.setMode(.num2048_5by5); hideAll() }, isSelected: game.getIs([.num2048_5by5]))
                                    ButtonStyled(title: "2048 (4 x 4)", action: { game.setMode(.num2048); hideAll() }, isSelected: game.getIs([.num2048]))
                                    ButtonStyled(title: "Colors (5 x 5)", action: { game.setMode(.colors); hideAll() }, isSelected: game.getIs([.colors]))
                                }                                        
                                .frame(maxHeight: 32.0)
//                                .disabled(true)
                                
                                Text("Game Data")
                                ButtonStyled(title: "Reset Data", 
                                             action: { 
                                    game.clear()
                                    hideAll()
                                })
                                .frame(maxHeight: 32.0)
                                
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
