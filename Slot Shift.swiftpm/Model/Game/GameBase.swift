import SwiftUI

enum GameMode: String, CaseIterable, Codable {
    case none, num2048_5by5, num2048, colors
}

enum GameMove {
    case none, up, down, left, right, fillSlot
    case SY_newGame, SY_reset 
}

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
    
    // Game event lifecycle
    func gameTick(_ tick: UInt)
    func gameFinalizeTick(_ tick: UInt)
    // Game logic 
}

class GameBase<S: Mergable> : ObservableObject, Codable, GameBehaviour {
    typealias M = Matrix<S>
    typealias H = [M.Data]
    
    @Published internal var matrix: M
    @Published internal var history: H
    
    @Published public var score: GameScore = GameScore()
    public let config: GameConfig
    
    public var historyCount: Int { get { return history.count } }
    public var anyEmpty: Bool { return matrix.anyEmpty() }
    
    func getMatrix() -> M { return matrix }
    
    required init(_ cfg: GameConfig) {
        self.config = cfg;
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
            score.turns += 1   
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
            _ = history.remove(at: history.count - 1)
            
            if(mergeDiff >= 0) {
                score.merges -= (mergeDiff + 1)
            }
        }
    }
    internal func reset() {
        matrix.clear(baseValue: .empty)
        history = []
        score = GameScore()
    }
    internal func prepareMove() {
        history.append(matrix.data)
        if (history.count > Statics.maxHistory)
        { history.removeFirst(history.count - Statics.maxHistory) }
    }
    internal func finalizeMove() {
        move_FillSlot()
        score.turns += 1
    }
    // game frame events called by game handle
    func gameTick(_ tick: UInt) { }
    func gameFinalizeTick(_ tick: UInt) { }
    
    
    enum CodingKeys: CodingKey {
        case matrix, history, score, config
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matrix = try container.decode(M.self, forKey: .matrix)
        self.history = try container.decode(H.self, forKey: .history)
        
        self.score = try container.decode(GameScore.self, forKey: .score)
        self.config = try container.decode(GameConfig.self, forKey: .config)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.matrix, forKey: .matrix)
        try container.encode(self.history, forKey: .history)
        
        try container.encode(self.score, forKey: .score)
        try container.encode(self.config, forKey: .config)
    }
    
}


class Game2048: GameBase<Slot2048> {
}

class GameColors: GameBase<SlotColor> {
    override func gameTick(_ tick: UInt) {
        if tick % 5 == 0 || tick % 11 == 0 {
            self.move_FillSlot()
        } 
    }
}
