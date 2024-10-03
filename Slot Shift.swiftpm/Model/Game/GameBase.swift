import SwiftUI

enum GameMode: String, CaseIterable, Codable {
    case none, num2048_5by5, num2048, colors
}

enum GameMove {
    case none, up, down, left, right, fillSlot
    case SY_newGame, SY_reset 
}

class GameBase<S: Mergable> : ObservableObject, Codable, GameBehaviour {
    typealias M = Matrix<S>
    typealias H = [M.Data]
    
    @Published public var matrix: M
    @Published var history: H
    
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
        if history.count > 0, let lastHistory = history.last {
            let mergeDiff = self.matrix.data.getEmptyCount() - lastHistory.getEmptyCount()
            
            self.matrix.data = lastHistory
            _ = history.remove(at: history.count-1)
            
            if(mergeDiff >= 0) {
                mergedCount -= (mergeDiff)
            }
            print("Revert: \(history.count) \(mergeDiff)")
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
        if (history.count > Statics.maxHistory)
        { history.removeFirst(history.count - Statics.maxHistory) }
    }
    internal func finalizeMove() {
        move_FillSlot()
        turnCount += 1
    }
    
    enum CodingKeys: CodingKey {
        case matrix, history, mergeCondition, mergeMode, turnCount, slotCount, mergedCount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matrix = try container.decode(M.self, forKey: .matrix)
        self.history = try container.decode(H.self, forKey: .history)
        
        self.mergeCondition = try container.decode(MergeCondition.self, forKey: .mergeCondition)  
        self.mergeMode = try container.decode(MergeMode.self, forKey: .mergeMode)
        
        self.turnCount = try container.decode(Int.self, forKey: .turnCount)
        self.slotCount = try container.decode(Int.self, forKey: .slotCount)
        self.mergedCount = try container.decode(Int.self, forKey: .mergedCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.matrix, forKey: .matrix)
        try container.encode(self.history, forKey: .history)
        
        try container.encode(self.mergeCondition, forKey: .mergeCondition)
        try container.encode(self.mergeMode, forKey: .mergeMode)
        
        try container.encode(self.turnCount, forKey: .turnCount)
        try container.encode(self.slotCount, forKey: .slotCount)
        try container.encode(self.mergedCount, forKey: .mergedCount)
    }
    
}
