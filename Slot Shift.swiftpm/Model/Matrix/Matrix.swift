import SwiftUI

class Matrix<T: Mergable> : ObservableObject, Codable {
    typealias Data = [T]
    let size: MatrixSize
    @Published public var data: Data
    
    required init(rows: Int, columns: Int, baseValue: T) {
        self.size = MatrixSize(rows: rows, columns: columns)
        data = Array(repeating: baseValue, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < size.rows && column >= 0 && column < size.columns
    }
    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return data[(row * size.columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            data[(row * size.columns) + column] = newValue
        }
    }
    
    func swap(_ sRow: Int, _ sCol: Int, _ dRow: Int, _ dCol: Int) {
        let tmp: T = self[sRow, sCol]
        self[sRow, sCol] = self[dRow, dCol]
        self[dRow, dCol] = tmp
    }
    
    func clear(baseValue: T) {
        data = Array(repeating: baseValue, count: size.rows * size.columns)   
    }
    
    func shiftDown(condition: MergeCondition = .none,_ clearValue: T) -> Int {
        moveColumns(by: 1, clearValue)
        let merged: Int = mergeColumns(by: 1, condition: condition, clearValue)
        moveColumns(by: 1, clearValue)
        return merged
    }
    func shiftUp(condition: MergeCondition = .none, _ clearValue: T) -> Int {
        moveColumns(by: -1, clearValue)
        let merged: Int = mergeColumns(by: -1, condition: condition, clearValue)
        moveColumns(by: -1, clearValue)
        return merged
    }
    func shiftLeft(condition: MergeCondition = .none, _ clearValue: T) -> Int {
        moveRows(by: -1, clearValue)
        let merged: Int = mergeRows(by: -1, condition: condition, clearValue)
        moveRows(by: -1, clearValue)
        return merged
    }
    func shiftRight(condition: MergeCondition = .none, _ clearValue: T) -> Int {
        moveRows(by: 1, clearValue)
        let merged: Int = mergeRows(by: 1, condition: condition, clearValue)
        moveRows(by: 1, clearValue)
        return merged
    }
    
    func addRandom(mergeMode: MergeMode) -> Int {
        // get coords for random picked empty slot
        let emptyCoords: MatrixCoords = randomEmptyCoords()
        if(emptyCoords.isValid) {
            // get new random value
            var newSlot = T.WEIGHTED.randomElement()
            // copy merge mode
            newSlot.Mode = mergeMode
            // replace empty slot with new value
            self[emptyCoords.row, emptyCoords.col] = newSlot 
            return 1
        }
        return 0
    }
    
    enum CodingKeys: String, CodingKey {
        case size, data
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.size = try container.decode(MatrixSize.self, forKey: .size)
        self.data = try container.decode(Data.self, forKey: .data)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.size, forKey: .size)
        try container.encode(self.data, forKey: .data)
    }
    
}
