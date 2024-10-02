import SwiftUI

extension Statics {
    static private let colors: [Color] = [.pink, .red, .orange, .cyan, .blue, .purple]
    
    static private var _accentColor: Color = .clear
    static var accentColor: Color { get {
        if _accentColor == .clear {
            _accentColor = Statics.colors.randomElement()!
        }
        return _accentColor
    }}
    
}
