import SwiftUI

class GameHandle : ObservableObject {
    @Published var games: GameCollection = GameCollection()
    @Published var mode: GameMode = .none
    @Published var slot: Int = 0
    @Published var tick: UInt = 0
    
    func startGame(_ newMode: GameMode) { 
        setMode(newMode)
        nextTurn(.SY_newGame)
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
}
