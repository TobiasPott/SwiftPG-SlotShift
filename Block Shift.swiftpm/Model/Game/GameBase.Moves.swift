import SwiftUI

extension GameBase {

    func move_Down() {
        // Move 'Down'
        mergedCount += matrix.shiftDown(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    func move_Up() {
        // Move 'Up'
        mergedCount += matrix.shiftUp(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    func move_Left() {
        // Move 'Left'
        mergedCount += matrix.shiftLeft(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    func move_Right() {
        // Move 'Right'
        mergedCount += matrix.shiftRight(condition: self.mergeCondition, .empty)
        finalizeMove()
    }
    func move_FillSlot() {        
        // Move 'Fill Slot'
        slotCount += matrix.addRandom(mergeMode: mergeMode)
    }
    
    
}
