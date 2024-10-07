import SwiftUI
extension Statics {
    static let maxHistory: Int = 15
    
    static let icon_2048_4x4: Image = Image("Icon_Numbers4x4").resizable()
    static let icon_2048_5x5: Image = Image("Icon_Numbers5x5").resizable()
    static let icon_colors_5x5: Image = Image("Icon_Colors5x5").resizable()
    
    
    static private let icons: [GameMode: Image] = [.num2048: icon_2048_4x4, .num2048_5by5: icon_2048_5x5, .colors: icon_colors_5x5]
    static private let names: [GameMode:LocalizedStringKey] = [.none: "None", .num2048_5by5: "2048 (5 x 5)", .num2048: "2048 (Classic)", .colors: "Color (5 x 5)"]
    static private let slotIds: [String] = ["I", "II", "III", "IV"]
    
    
    static func getName(_ mode: GameMode) -> LocalizedStringKey { return Statics.names[mode]! }
    static func getIcon(_ mode: GameMode) -> Image { return Statics.icons[mode]! }
    static func getSlotId(_ idx: Int) -> String { return Statics.slotIds[idx] }
    
    static func make<T: Mergable>(_ cfg: GameConfig = .GameCfg5x5, _ repeating: Int) -> [GameBase<T>] {
        var result:[GameBase<T>] = []
        for _ in 0..<repeating { result.append(.init(cfg)) }
        return result
    }
    static func make<T: Mergable>(_ cfg: GameConfig = .GameCfg5x5) -> GameBase<T> {
        return .init(cfg)
    }
    
}
