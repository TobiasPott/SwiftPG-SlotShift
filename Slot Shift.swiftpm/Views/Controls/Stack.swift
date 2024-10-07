import SwiftUI

struct Stack<Content: View>: View {
    enum Layout {
        case horizontal, vertical
    }
    
    var layout: Layout = .horizontal
    @ViewBuilder let content: () -> Content
    var spacing: CGFloat = 10.0
    var verticalAlignment: VerticalAlignment = .center
    var horizontalAlignment: HorizontalAlignment = .center
    
    var body: some View {
        if layout == .horizontal {
            HStack(alignment: verticalAlignment, spacing: spacing) { content() }
        } else {
            VStack(alignment: horizontalAlignment, spacing: spacing) { content() }            
        }
    }
}
