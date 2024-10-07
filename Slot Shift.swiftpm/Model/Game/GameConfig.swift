import SwiftUI

struct GameConfig: Codable {
    static let GameCfg5x5: GameConfig = .init(rows: 5, columns: 5)
    static let GameCfg4x4: GameConfig = .init(rows: 4, columns: 4)
    
    static let colorsCfg5x5: GameConfig = .init(rows: 5, columns: 5, condition: .match, mode: .clear)
    
    
    let rows, columns: Int
    
    var condition: MergeCondition = .match
    var mode: MergeMode = .add
}
