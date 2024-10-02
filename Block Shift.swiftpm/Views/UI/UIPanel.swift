import SwiftUI

struct UIPanel<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        content() 
            .padding()
            .padding(.vertical, 6.0)
            .padding(.horizontal, 6.0)
            .backgroundPanel()
            .font(Statics.bodyFont)
        
    }
}
