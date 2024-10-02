import SwiftUI

struct GameConfig {
    let rows: Int
    let columns: Int
}

class GameCollection : ObservableObject {
    
    @Published var games2048_5by5: [GameBase<SlotNumber>] = [.init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5)]
    @Published var games2048: [GameBase<SlotNumber>] = [.init(GameStatics.GameCfg4x4), .init(GameStatics.GameCfg4x4), .init(GameStatics.GameCfg4x4), .init(GameStatics.GameCfg4x4)]
    @Published var gamesColors: [GameBase<SlotRGB>] = [.init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5), .init(GameStatics.GameCfg5x5)]
    @Published var turnCount: Int = 0 
    
    func getGame(_ mode: GameMode, _ slot: Int = 0) -> GameBehaviour? {
        switch mode {
        case .num2048_5by5: return games2048_5by5[slot]
        case .num2048:      return games2048[slot]
        case .colors:       return gamesColors[slot]
        default:            return nil
        }        
    }
    
    func nextTurn(_ mode: GameMode, _ slot: Int = 0, move: GameMove) {
        turnCount += 1;
        if let game = getGame(mode, slot) { game.nextTurn(move) }
    }
    func anyEmpty(_ mode: GameMode, _ slot: Int = 0) -> Bool {
        if let game = getGame(mode, slot) { return game.anyEmpty }
        return true
    }
    func revert(_ mode: GameMode, _ slot: Int = 0) {        
        if let game = getGame(mode, slot) { game.revert() }
    } 
    func getTurnCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        if let game = getGame(mode, slot) { return game.turnCount }
        return 0
    }
    func getHistoryCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        if let game = getGame(mode, slot) { return game.historyCount }
        return 0
    }
    func getMergedCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        if let game = getGame(mode, slot) { return game.mergedCount }
        return 0
    }
    
}
