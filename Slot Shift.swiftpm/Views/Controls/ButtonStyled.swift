import SwiftUI

struct ButtonStyled: View {
    var title: LocalizedStringKey = ""
    var action: () -> Void = {}

    var isSelected: Bool = true    
    var withAnim: Bool = true
    var color: Color = Statics.accentColor
    
    var body: some View {
        Button(title) {
            if withAnim {
                withAnimation { action() }
            } else { action() }
        }
        .backgroundButton(isSelected ? color : Color(.sRGB, white: 0.70, opacity: 1.0))
    }
}
