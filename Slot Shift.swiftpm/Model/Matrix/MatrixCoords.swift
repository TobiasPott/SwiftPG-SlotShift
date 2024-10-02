import SwiftUI

struct MatrixCoords: Equatable, Codable {
    static let invalid: MatrixCoords = .init(-1, -1)
    
    // row index (vertical, top to bottom)
    let row: Int 
    // column index (horizontal, left to right)
    let col: Int    
    
    var isValid: Bool { get { return row >= 0 && col >= 0 }}
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}
