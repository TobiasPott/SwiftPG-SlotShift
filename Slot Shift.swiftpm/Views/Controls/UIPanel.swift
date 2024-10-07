import SwiftUI

struct UIPanel<Content: View>: View {
    var color: Color = Statics.accentColor
    var content: () -> Content
    
    var body: some View {
        content() 
            .padding()
            .padding(.bottom, 6.0)
            .padding(.horizontal, 6.0)
            .backgroundPanel(color)
            .font(Statics.bodyFont)
        
    }
}
