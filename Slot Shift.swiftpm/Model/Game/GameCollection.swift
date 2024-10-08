import SwiftUI

class GameCollection : ObservableObject, Codable {
    typealias GameType2048 = Game2048
    typealias GameTypeColors = GameColors
    
    @Published var games2048_5by5: [GameType2048] 
    @Published var games2048: [GameType2048]
    @Published var gamesColors: [GameTypeColors]
    
    init() {
        games2048_5by5 = [.init(.GameCfg5x5), .init(.GameCfg5x5), .init(.GameCfg5x5), .init(.GameCfg5x5)]
        games2048 = [.init(.GameCfg4x4), .init(.GameCfg4x4), .init(.GameCfg4x4), .init(.GameCfg4x4)]
        gamesColors = [.init(.colorsCfg5x5), .init(.colorsCfg5x5), .init(.colorsCfg5x5), .init(.colorsCfg5x5)]
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
        if let game = getGame(mode, slot) { return game.score.turns }
        return 0
    }
    func getHistoryCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        if let game = getGame(mode, slot) { return game.historyCount }
        return 0
    }
    func getMergedCount(_ mode: GameMode, _ slot: Int = 0) -> Int {
        if let game = getGame(mode, slot) { return game.score.merges }
        return 0
    }
    
    enum CodingKeys: String, CodingKey {
        case games_numbers_5x5, games_numbers_4x4, games_colors_5x5
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games2048_5by5 = try container.decode([GameType2048].self, forKey: .games_numbers_5x5)
        self.games2048 = try container.decode([GameType2048].self, forKey: .games_numbers_4x4)
        self.gamesColors = try container.decode([GameTypeColors].self, forKey: .games_colors_5x5)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.games2048_5by5, forKey: .games_numbers_5x5)
        try container.encode(self.games2048, forKey: .games_numbers_4x4)
        try container.encode(self.gamesColors, forKey: .games_colors_5x5)
    }
    
}
