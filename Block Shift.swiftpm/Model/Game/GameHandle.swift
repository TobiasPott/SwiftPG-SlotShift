import SwiftUI

class GameHandle : ObservableObject, Codable {
    @Published var games: GameCollection = GameCollection()
    @Published var mode: GameMode = .none
    @Published var slot: Int = 0
    @Published var tick: UInt
    
    init() {
        tick = 0
    }
    func startGame(_ newMode: GameMode) { 
        setMode(newMode)
        nextTurn(.SY_newGame)
    }
    func quitGame() {
        self.save()
        self.setMode(.none)
    }
    func revert() {    
        tick += 1
        games.revert(mode, slot) 
    }
    func setMode(_ newMode: GameMode) { tick += 1; mode = newMode }
    func setSlot(_ newSlot: Int) { tick += 1; slot = newSlot }
    func nextTurn(_ move: GameMove) {
        tick += 1
        games.nextTurn(mode, slot, move: move)
    }
    func getGame() -> GameBehaviour { return games.getGame(mode, slot)! }
    func getGame(_ mode: GameMode) -> GameBehaviour { return games.getGame(mode, slot)! }
    
    enum CodingKeys: String, CodingKey {
        case games, mode, slot
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games = try container.decode(GameCollection.self, forKey: .games)
        self.mode = try container.decode(GameMode.self, forKey: .mode)
        self.slot = try container.decode(Int.self, forKey: .slot)
        self.tick = 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.games, forKey: .games)
        try container.encode(self.mode, forKey: .mode)
        try container.encode(self.slot, forKey: .slot)
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode(GameHandle.self, from: data) {
                self.tick = 0
                self.games = decoded.games
                self.setSlot(decoded.slot)
                self.setMode(decoded.mode)
                return
            }
        }
    }
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Statics.saveFileKey)
        }
    }
    
}
