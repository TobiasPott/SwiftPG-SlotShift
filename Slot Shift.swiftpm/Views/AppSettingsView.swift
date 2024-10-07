import SwiftUI

struct AppSettingsView: View {
    
    @StateObject var game: GameHandle = GameHandle()
    
    @State private var showContent: Bool = false
    
    func hideAll() { showContent = false; }
    
    var body: some View {
        let icon = Image(systemName: "gearshape.fill").resizable().aspectRatio(1.0, contentMode: .fill)
        let contentAlignment: Alignment = .topTrailing
        
        ZStack(alignment: contentAlignment) {
            ///-> CLICK-BLOCKER
            let blockerBackground = Rectangle().foregroundStyle(.black).opacity(0.25)
            Button(action: { withAnimation { hideAll() } }, label: { blockerBackground })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .isHidden(!showContent, remove: !showContent)
            
            ///-> CONTENT BLOCK
            VStack(alignment: contentAlignment.horizontal) {
                Button(action: { withAnimation { showContent.toggle() } }, 
                       label: { icon }).backgroundButton().frameMax(48, 48)
                
                UIPanel {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Change Mode")
                        Group {
                            // ToDo: add function to start/continue game if mode is set
                            ButtonStyled(title: "Numbers (5 x 5)", action: { startOrContinue(.num2048_5by5) }, isSelected: game.getIsSelected([.num2048_5by5]))
                            ButtonStyled(title: "Numbers (4 x 4)", action: { startOrContinue(.num2048) }, isSelected: game.getIsSelected([.num2048]))
                            ButtonStyled(title: "Colors (5 x 5)", action: { startOrContinue(.colors)  }, isSelected: game.getIsSelected([.colors]))
                        }                                        
                        .frame(maxHeight: 32.0)
                        
                        Text("Game Data")
                        ButtonStyled(title: "Reset Data", 
                                     action: { game.clear(); hideAll(); })
                        .frame(maxHeight: 32.0)
                        
                    }.frame(maxWidth: 220.0, alignment: contentAlignment)
                }
                .background(.brown.opacity(0.5))
                .transition(.move(edge: .top))
                .isHidden(!showContent, remove: !showContent)
            }
            .padding([.leading, .top, .trailing])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: contentAlignment)
            
        }
    }
    
    func startOrContinue(_ newMode: GameMode) {
        game.selectedMode = newMode
        // if a game is already active, override and change
        if game.mode != .none {
            game.setMode(newMode)
            if game.getGameBehaviour(newMode)?.historyCount == 0 {
                game.nextTurn(.SY_newGame)
            }
            
        }
        hideAll()
    }
    
}
