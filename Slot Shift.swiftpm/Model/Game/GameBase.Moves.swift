import SwiftUI

extension GameBase {
    
    /// Move implementation for shifting the game's playfield down
    func move_Down() {
        // Move 'Down'
        prepareMove()
        score.merges += matrix.shiftDown(condition: self.config.condition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield up
    func move_Up() {
        // Move 'Up'
        prepareMove()
        score.merges += matrix.shiftUp(condition: self.config.condition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield left
    func move_Left() {
        // Move 'Left'
        prepareMove()
        score.merges += matrix.shiftLeft(condition: self.config.condition, .empty)
        finalizeMove()
    }
    /// Move implementation for shifting the game's playfield right
    func move_Right() {
        // Move 'Right'
        prepareMove()
        score.merges += matrix.shiftRight(condition: self.config.condition, .empty)
        finalizeMove()
    }
    /// Move implementation for adding a random slot of the game's playfield 
    func move_FillSlot() {        
        // Move 'Fill Slot'
        score.slots += matrix.addRandom(mergeMode: self.config.mode)
    }
    
    
}
