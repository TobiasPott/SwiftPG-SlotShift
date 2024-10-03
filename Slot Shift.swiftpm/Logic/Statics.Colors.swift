import SwiftUI

extension Statics {
    ///->List of 'theme' colors
    static private let colors: [Color] = [Color.orange] 
    
    ///->Accent color storage member and read-only property to replace system's accentColor
    static private var _accentColor: Color = .clear
    static var accentColor: Color { get {
        if _accentColor == .clear {
            _accentColor = Statics.colors.randomElement()!
        }
        return _accentColor
    }}
    
}
