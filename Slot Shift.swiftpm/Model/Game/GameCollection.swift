import SwiftUI

struct GameConfig: Codable {
    static let GameCfg5x5: GameConfig = .init(rows: 5, columns: 5)
    static let GameCfg4x4: GameConfig = .init(rows: 4, columns: 4)
    
    let rows: Int
    let columns: Int
}

class GameCollection : ObservableObject, Codable {
    typealias GameTypeNumbers = GameBase<SlotNumber>
    typealias GameTypeColors = GameBase<SlotNumber>
    
    @Published var games2048_5by5: [GameTypeNumbers] 
    @Published var games2048: [GameTypeNumbers]
    @Published var gamesColors: [GameTypeColors]
    @Published var turnCount: Int = 0 
    
    init() {
        games2048_5by5 = Statics.make<SlotNumber>(.GameCfg5x5, 4)
        games2048 = Statics.make<SlotNumber>(.GameCfg4x4, 4)
        gamesColors = Statics.make<SlotRGB>(.GameCfg5x5, 4)
    }
    
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
    
    enum CodingKeys: String, CodingKey {
        case turnCount, games_numbers_5x5, games_numbers_4x4, games_colors_5x5
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games2048_5by5 = try container.decode([GameTypeNumbers].self, forKey: .games_numbers_5x5)
        self.games2048 = try container.decode([GameTypeNumbers].self, forKey: .games_numbers_4x4)
        self.gamesColors = try container.decode([GameTypeColors].self, forKey: .games_colors_5x5)
        self.turnCount = try container.decode(Int.self, forKey: .turnCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.games2048_5by5, forKey: .games_numbers_5x5)
        try container.encode(self.games2048, forKey: .games_numbers_4x4)
        try container.encode(self.gamesColors, forKey: .games_colors_5x5)
        try container.encode(self.turnCount, forKey: .turnCount)
    }
    
}
