import SwiftUI
extension Statics {
    static let maxHistory: Int = 15
    
    static private let icons: [GameMode: Image] = [.num2048: Image(systemName: "4.lane"), .num2048_5by5: Image(systemName: "5.lane"), .colors: Image(systemName: "c.circle")]
    static private let names: [GameMode:LocalizedStringKey] = [.none: "None", .num2048_5by5: "2048 (5 by 5)", .num2048: "2048 (Classic)", .colors: "Color (tbd)"]
    
    static func getName(_ mode: GameMode) -> LocalizedStringKey { return Statics.names[mode]! }
    static func getIcon(_ mode: GameMode) -> Image { return Statics.icons[mode]! }
    
    static func make<T: Mergable>(_ cfg: GameConfig = .GameCfg5x5, _ repeating: Int) -> [GameBase<T>] {
        var result:[GameBase<T>] = []
        for _ in 0..<repeating { result.append(.init(cfg)) }
        return result
    }
    static func make<T: Mergable>(_ cfg: GameConfig = .GameCfg5x5) -> GameBase<T> {
        return .init(cfg)
    }
    
}
