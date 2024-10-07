import SwiftUI

struct GameModeView: View {
    @Binding var mode: GameMode
    
    var body: some View {
        UIPanel {
            VStack() {
                // header
                HStack {
                    Text("Mode").font(Statics.calloutFont).fontWeight(.bold)
                    let strMode: LocalizedStringKey = Statics.getName(mode)
                    HStack(spacing: 0.0) {
                        Text("'"); Text(strMode); Text("'")
                    }
                    .font(Statics.calloutFont).fontWeight(.bold) 
                }
                // buttons for mode selection
                HStack(spacing: -4) {
                    let size: CGFloat = 92
                    ForEach(GameMode.allCases, id: \.self) { i in
                        if i == .none { EmptyView() } 
                        else { 
                            
                            Button(action: { mode = i }, 
                                   label: { Statics.getIcon(i).resizable().aspectRatio(contentMode: .fit) })
                            .foregroundStyle(i != mode ? Color.primary : Color.black)
                            .colorMultiply(i == mode ? .white : .gray)
                            .frame(width: size, height: size)
                        }
                        
                    }
                }
                .padding(.horizontal, -8)
                .padding(.bottom, -8)
            }         
        }
        
    }
}
