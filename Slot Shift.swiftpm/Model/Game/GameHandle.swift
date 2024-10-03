import SwiftUI

class GameHandle : ObservableObject, Codable {
    @Published var games: GameCollection = GameCollection()
    @Published var mode: GameMode = .none
    @Published var slot: Int = 0
    @Published var tick: UInt
    
    init() {
        tick = 0
    }
    func clear() {
        games = GameCollection()
        mode = .none
        slot = 0
        tick = 0
    }
    func startGame(_ newMode: GameMode) { 
        setMode(newMode)
        nextTurn(.SY_newGame)
    }
    func quitGame() {
        self.setMode(.none)
        self.save()
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
        if let data = UserDefaults.standard.string(forKey: Statics.saveFileKey) {
            //            print ("Loaded data for '\(Statics.saveFileKey)'")
            let decoder = JSONDecoder()
            do {
                
                let game = try decoder.decode(GameHandle.self, from: data.data(using: .utf8)!)
                
                self.tick = 0
                self.games = game.games
                self.setSlot(game.slot)
                self.setMode(game.mode)
                self.tick += 1
                //                print ("Fully loaded game state")
                return
                
            } catch let DecodingError.keyNotFound(key, context) {
                print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
            } catch let DecodingError.dataCorrupted(context) {
                print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
            } catch let DecodingError.valueNotFound(type, context) {
                print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
            } catch let error {
                print("Coding path: \(error.localizedDescription)")
            }
            
            
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(String(data: encoded, encoding: .utf8)!, forKey: Statics.saveFileKey)
        }
    }
    
}
