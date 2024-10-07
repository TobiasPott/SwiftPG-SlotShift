import SwiftUI

struct GameScore: Codable {
    public var turns: Int = 0
    public var slots: Int = 0
    public var merges: Int = 0
    public var score: CGFloat = 0.0
}
