import SwiftUI

class GameHandle : ObservableObject, Codable {
    static private let defaultGameMode: GameMode = .colors
    
    @Published private var games: GameCollection = GameCollection()
    @Published var mode: GameMode = .none
    @Published var selectedMode: GameMode = defaultGameMode
    @Published var slot: Int = 0
    
    @Published var tick: UInt = 0
    
    init() { }
    func clear() {
        games = GameCollection()
        mode = .none
        selectedMode = GameHandle.defaultGameMode
        slot = 0
        tick = 0
        UserDefaults.standard.set("{}", forKey: Statics.saveFileKey)
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
        onTick()
        games.revert(mode, slot) 
    }
    func setMode(_ newMode: GameMode, _ skipTick: Bool = false) { 
        if !skipTick { onTick() }
        mode = newMode 
    }
    func setSlot(_ newSlot: Int, _ skipTick: Bool = false) { 
        if !skipTick { onTick() }
        slot = newSlot 
    }
    func nextTurn(_ move: GameMove, _ skipTick: Bool = false) {
        if !skipTick { onTick() }
        games.nextTurn(mode, slot, move: move)
    }
    func getGameBehaviour() -> GameBehaviour? { return games.getGame(mode, slot) }
    func getGameBehaviour(_ mode: GameMode) -> GameBehaviour? { return games.getGame(mode, slot) }
    
    func getAs<T: Mergable>() -> GameBase<T>? { return getGameBehaviour() as? GameBase<T> }
    func getIs(_ modes: [GameMode]) -> Bool { return modes.contains { gameMode in
        return gameMode == self.mode
    } }
    func getIsSelected(_ modes: [GameMode]) -> Bool { return modes.contains { gameMode in
        return gameMode == self.selectedMode
    } }
    internal func onTick() {
        if let gameBehaviour = getGameBehaviour() {
            gameBehaviour.gameTick(tick)
            tick += 1
            gameBehaviour.gameFinalizeTick(tick)
        } else {
            tick += 1
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case games, mode, selectedMode, slot
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games = try container.decode(GameCollection.self, forKey: .games)
        self.mode = try container.decode(GameMode.self, forKey: .mode)
        self.selectedMode = try container.decode(GameMode.self, forKey: .selectedMode)
        self.slot = try container.decode(Int.self, forKey: .slot)
        self.tick = 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.games, forKey: .games)
        try container.encode(self.mode, forKey: .mode)
        try container.encode(self.selectedMode, forKey: .selectedMode)
        try container.encode(self.slot, forKey: .slot)
    }
    
    func load() {
        if let data = UserDefaults.standard.string(forKey: Statics.saveFileKey) {
            let decoder = JSONDecoder()
            do {
                let game = try decoder.decode(GameHandle.self, from: data.data(using: .utf8)!)
                self.tick = 0
                self.games = game.games
                self.selectedMode = game.selectedMode
                self.setSlot(game.slot, true)
                self.setMode(game.mode, true)
                self.onTick()
                return
                
            } catch let DecodingError.keyNotFound(key, context) {
                print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
                save()
            } catch let DecodingError.dataCorrupted(context) {
                print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
                save()
            } catch let DecodingError.typeMismatch(type, context) {
                print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
                save()
            } catch let DecodingError.valueNotFound(type, context) {
                print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
                print("Coding path: \(context.codingPath)")
                save()
            } catch let error {
                print("Coding path: \(error.localizedDescription)")
                save()
            }
            
        }
        
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            print("Game saved.")
            UserDefaults.standard.set(String(data: encoded, encoding: .utf8)!, forKey: Statics.saveFileKey)
        }
    }
    
}
