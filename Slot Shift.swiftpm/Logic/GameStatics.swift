import SwiftUI



class GameStatics {
    static let maxHistory: Int = 25
    
    static let GameCfg5x5: GameConfig = .init(rows: 5, columns: 5)
    static let GameCfg4x4: GameConfig = .init(rows: 4, columns: 4)
    
    static let colors: [Color] = [.pink, .red, .orange, /*.yellow,*/ /*.green,*/ .cyan, .blue, .purple]
    static let names: [GameMode:LocalizedStringKey] = [.none: "None", .num2048_5by5: "2048 (5 by 5)", .num2048: "2048 (Classic)", .colors: "Color (tbd)"]
    
    static private var _accentColor: Color = .clear
    static var accentColor: Color { get {
        if _accentColor == .clear {
            _accentColor = GameStatics.colors.randomElement()!
        }
        return _accentColor
    }}
    
    
    static let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(.sRGB, white: 0.2, opacity: 0.5), GameStatics.accentColor]), startPoint: .top, endPoint: .bottom)
    
    
    static func getName(_ mode: GameMode) -> LocalizedStringKey { return GameStatics.names[mode]! }
    
}



