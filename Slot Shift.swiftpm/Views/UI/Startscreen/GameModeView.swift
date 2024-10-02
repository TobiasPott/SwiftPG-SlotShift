import SwiftUI

struct GameModeView: View {
    @Binding var mode: GameMode
    
    var body: some View {
        VStack {
            // header
            HStack { Text("Mode \(mode)"); Spacer() }
            // buttons for mode selection
            HStack(spacing: 16) {
                ForEach(GameMode.allCases, id: \.self) { i in
                    if i == .none { EmptyView() } 
                    else { 
                        Button(action: { mode = i }, 
                               label: { Statics.getIcon(i).resizable().aspectRatio(contentMode: .fit) })
                        .foregroundStyle(i != mode ? Color.primary : Color.black)
                        .backgroundButton(i != mode ? Statics.accentColor : .gray)
                    }
                    
                }
            }
            .frame(maxHeight: 48.0)
        }         
        .padding()
        .padding(.bottom, 4)
        .backgroundPanel()
        
    }
}
