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
    func setMode(_ newMode: GameMode) { tick += 1; mode = newMode }
    func nextTurn(_ move: GameMove) {
        tick += 1
        games.nextTurn(mode, slot, move: move)
    }
}
