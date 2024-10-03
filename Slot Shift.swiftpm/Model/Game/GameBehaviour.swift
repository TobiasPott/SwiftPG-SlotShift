import SwiftUI

protocol GameBehaviour {
    // Members
    var score: GameScore { get }
    var historyCount: Int { get }
    var anyEmpty: Bool { get }
    
    // Ctor
    init(_ cfg: GameConfig)
    
    // Functions
    func newGame()
    func revert()
    func reset()
    func nextTurn(_ move: GameMove)
}
