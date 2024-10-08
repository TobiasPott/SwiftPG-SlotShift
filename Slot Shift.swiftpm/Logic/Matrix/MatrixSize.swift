import SwiftUI

struct MatrixSize: Equatable, Codable {
    // number of rows (vertical, top to bottom)
    let rows: Int 
    // number of columns (horizontal, left to right)
    let columns: Int    
    
    // total number of slots in the matrix
    var count: Int { get { return rows * columns } }
    // gets the start row index for the given by amount
    func getStartRow(_ by: Int) -> Int { return by > 0 ? 0 : 1 } 
    // gets the end row index for the given by amount
    func getEndRow(_ by: Int) -> Int { return by > 0 ? rows-2 : rows-1 }
    // gets the end row index for the reverse loop for the given by amount
    func getRevEndRow(_ by: Int) -> Int { return by > 0 ? rows-1 : 0 }
    
    
    // gets the start row index for the given by amount
    func getStartColumn(_ by: Int) -> Int { return by > 0 ? 0 : 1 }
    // gets the end row index for the given by amount
    func getEndColumn(_ by: Int) -> Int { return by > 0 ? columns-2 : columns-1 }
    // gets the end column index for the reverse loop for the given by amount
    func getRevEndColumn(_ by: Int) -> Int { return by > 0 ? columns-1 : 0 }
    
}
