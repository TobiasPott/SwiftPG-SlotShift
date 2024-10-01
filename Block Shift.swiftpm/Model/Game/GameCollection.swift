import SwiftUI

struct GameConfig {
    let rows: Int
    let columns: Int
}

class GameCollection : ObservableObject {
    static let cfg5x5: GameConfig = .init(rows: 5, columns: 5)
    static let cfg4x4: GameConfig = .init(rows: 4, columns: 4)
    
    @Published var games2048_5by5: [GameBase<SlotNumber>] = [.init(cfg5x5), .init(cfg5x5), .init(cfg5x5), .init(cfg5x5)]
    @Published var games2048: [GameBase<SlotNumber>] = [.init(cfg4x4), .init(cfg4x4), .init(cfg4x4), .init(cfg4x4)]
    @Published var gamesColors: [GameBase<SlotRGB>] = [.init(cfg5x5), .init(cfg5x5), .init(cfg5x5), .init(cfg5x5)]
    @Published var turnCount: Int = 0 
    
    func anyEmpty(_ mode: GameMode, _ slot: Int = 0) -> Bool {
        switch mode {
        case .num2048_5by5: return games2048_5by5[slot].anyEmpty
        case .num2048:      return games2048[slot].anyEmpty
        case .colors:       return gamesColors[slot].anyEmpty
        default:            return true
        }
    }
    
    func getTurnCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        switch mode {
        case .num2048_5by5: return games2048_5by5[slot].turnCount
        case .num2048:      return games2048[slot].turnCount
        case .colors:       return gamesColors[slot].turnCount
        default:            return 0
        }
    }
    func getHistoryCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        switch mode {
        case .num2048_5by5: return games2048_5by5[slot].historyCount
        case .num2048:      return games2048[slot].historyCount
        case .colors:       return gamesColors[slot].historyCount
        default:            return 0
        }
    }
    func getMergedCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        switch mode {
        case .num2048_5by5: return games2048_5by5[slot].mergedCount
        case .num2048:      return games2048[slot].mergedCount
        case .colors:       return gamesColors[slot].mergedCount
        default:            return 0
        }
    }
    
}
