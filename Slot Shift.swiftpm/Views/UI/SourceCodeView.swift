import SwiftUI

struct SourceCodeView: View {
    let sourceCode: String
    
     @State private var opacity: Double = 0.0
    @State private var radius: Double = 0.25
    
    var body: some View {
        let bgColor = Color(.sRGB, white: 0.85, opacity: 1.0)
        
        VStack {
            Text(sourceCode)
                .font(Statics.captionFont)
                .foregroundStyle(bgColor)
                .shadowDrop(radius: radius, x: 0.0, y: -1.0)
                .padding()        
                .opacity(opacity)        
                .onAppear(perform: { withAnimation(.easeInOut(duration: 1.0)) { 
                    opacity = 1.0
                    radius = 0.5
                } })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .background(bgColor)

        
    }
}
