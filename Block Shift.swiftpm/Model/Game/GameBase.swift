import SwiftUI

enum GameMove {
    case none, up, down, left, right, fillSlot
    case SY_newGame, SY_reset 
}

class GameBase<S: Mergable> : ObservableObject, GameBehaviour {
    typealias M = Matrix<S>
    
    private let maxHistory: Int = 25
    
    @Published public var matrix: M
    @Published var history: [M.Data]
    
    @Published public var mergeCondition: MergeCondition = .matchRGB
    @Published public var mergeMode: MergeMode = .add
    
    @Published public var turnCount: Int = 0
    @Published public var slotCount: Int = 0
    @Published public var mergedCount: Int = 0
    public var historyCount: Int { get { return history.count } }
    public var anyEmpty: Bool { return matrix.anyEmpty() }
    
    public var rows: Int { return matrix.size.rows }
    public var columns: Int { return matrix.size.columns }
    
    required init(_ cfg: GameConfig) {
        self.matrix = .init(rows: cfg.rows, columns: cfg.columns, baseValue: .empty)
        self.history = []
    }
    
    
    func nextTurn(_ move: GameMove) {
        switch move {
        case .down: move_Down()
        case .up: move_Up()
        case .left: move_Left()
        case .right: move_Right()
        case .fillSlot: move_FillSlot()
        case .SY_newGame: newGame()
        case .SY_reset: reset()
        default:
            turnCount += 1   
        }
    }
    
    internal func newGame() {
        self.reset()
        self.nextTurn(.fillSlot)
    }
    internal func revert() {
        if history.count > 0 {
            let lastHistory = history.last!
            let mergeDiff = self.matrix.data.getEmptyCount() - lastHistory.getEmptyCount()
            
            if(mergeDiff <= 0) {
                self.matrix.data = lastHistory
                history.dropLast()
                // ToDo: do the actual revert of data and reduction of counts
                //        also remove last history from list
            }
            print("Revert: \(self.matrix.data.count) \(mergeDiff)")
        }
    }
    internal func reset() {
        matrix.clear(baseValue: .empty)
        history = []
        turnCount = 0
        slotCount = 0
        mergedCount = 0
    }
    internal func prepareMove() {
        history.append(matrix.data)
        if (history.count > self.maxHistory)
        { history.removeFirst(history.count - self.maxHistory) }
    }
    internal func finalizeMove() {
        move_FillSlot()
        turnCount += 1
    }
    
}
