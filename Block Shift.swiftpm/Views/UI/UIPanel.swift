import SwiftUI

struct UIPanel<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        content() 
            .padding()
            .padding(.vertical, 6.0)
            .padding(.horizontal)
            .backgroundPanel()
            .font(Statics.bodyFont)
        
    }
}
