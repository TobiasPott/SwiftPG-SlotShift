import SwiftUI

struct UIButton<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        content() 
            .padding()
            .padding(.vertical, 6.0)
            .padding(.horizontal)
            .backgroundButtonNEW()
            .font(Statics.bodyFont)
        
    }
}
