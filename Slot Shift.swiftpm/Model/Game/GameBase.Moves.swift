import SwiftUI

extension GameBase {
    
    /// Move implementation for shifting the game's playfield down
    func move_Down() {
        // Move 'Down'
        prepareMove()
        mergedCount += matrix.shiftDown(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield up
    func move_Up() {
        // Move 'Up'
        prepareMove()
        mergedCount += matrix.shiftUp(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield left
    func move_Left() {
        // Move 'Left'
        prepareMove()
        mergedCount += matrix.shiftLeft(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield right
    func move_Right() {
        // Move 'Right'
        prepareMove()
        mergedCount += matrix.shiftRight(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    /// Move implementation for adding a random slot of the game's playfield 
    func move_FillSlot() {        
        // Move 'Fill Slot'
        slotCount += matrix.addRandom(mergeMode: mergeMode)
    }
    
    
}
