import SwiftUI

extension Matrix where T: Equatable {
    
    func anyEmpty() -> Bool {
        for row in 0..<size.rows {
            for col in 0..<size.columns {
                if(self[row, col].isEmpty) {
                    return true
                }
            }   
        }
        return false
    }
    
    func randomEmptyCoords() -> MatrixCoords {
        // map array to index/value pairs
        let empties: [(index: Int, value: T)] = data.enumerated().map { (index, m) in
            return (index: index, value: m)
        }.filter({ e in
            // filter for empty only
            return e.value.isEmpty
        })
        // check of no empties exist
        if empties.count <= 0 { return .invalid }
        
        // pick random element
        let empty = empties.randomElement()!
        // calc row index = flat-index divided by number of columns per row
        let row: Int = empty.index / self.size.columns
        // calc column index = row index multiplied by columns per row
        let col: Int = empty.index - (row * self.size.columns)
        return .init(row, col)
    }
}
