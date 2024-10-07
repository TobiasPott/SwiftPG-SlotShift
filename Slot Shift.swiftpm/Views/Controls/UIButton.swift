import SwiftUI

struct UIButton<Content: View>: View {
    var content: () -> Content
    var isSelected: Bool = true
    var color: Color = Statics.accentColor    
    
    var body: some View {
        content() 
            .padding()            
            .padding(.bottom, 6.0)
            .padding(.horizontal)
            .backgroundButton(isSelected ? color : Color(.sRGB, white: 0.70, opacity: 1.0))
            .font(Statics.bodyFont)        
    }
}
