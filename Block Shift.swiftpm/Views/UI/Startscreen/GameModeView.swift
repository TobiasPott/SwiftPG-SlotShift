import SwiftUI

struct GameModeView: View {
    static let icons: [GameMode: Image] = [.num2048: Image(systemName: "4.lane"), .num2048_5by5: Image(systemName: "5.lane"), .colors: Image(systemName: "c.circle")]
    
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
                               label: { GameModeView.icons[i
                               ]!.resizable().aspectRatio(contentMode: .fit) })
                        .foregroundStyle(i != mode ? Color.primary : Color.black)
                        .backgroundButton(i != mode ? GameStatics.accentColor : .gray)
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
