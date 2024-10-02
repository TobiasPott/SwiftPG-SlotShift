import SwiftUI

protocol GameBehaviour {
    // Members
    var turnCount: Int { get }
    var slotCount: Int { get }
    var mergedCount: Int { get }
    var historyCount: Int { get }
    var anyEmpty: Bool { get }
    
    var rows: Int { get }
    var columns: Int { get }
    
    // Ctor
    init(_ cfg: GameConfig)
    
    // Functions
    func newGame()
    func revert()
    func reset()
    func nextTurn(_ move: GameMove)
}
