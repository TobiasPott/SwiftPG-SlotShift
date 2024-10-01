import SwiftUI

extension GameCollection {
    
    func nextTurn(_ mode: GameMode, _ slot: Int = 0, move: GameMove) {
        turnCount += 1;
        switch mode {
        case .num2048_5by5: games2048_5by5[slot].nextTurn(move)
        case .num2048:      games2048[slot].nextTurn(move)
        case .colors:       gamesColors[slot].nextTurn(move)
        default:            return
        }
//        print("nextTurn: \(mode)(\(slot)).\(move)")
    }
    
}
