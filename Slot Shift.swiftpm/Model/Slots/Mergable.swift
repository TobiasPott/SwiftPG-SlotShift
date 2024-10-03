import SwiftUI


enum MergeCondition: Int, Codable {
    case none, matchRGB, match
}
enum MergeMode: Int, Codable {
    case add, subtract, half, double, replace, clear
}


protocol Mergable : Equatable, Codable {
    static var WEIGHTED: Picklist<Self> { get }
    static var empty: Self { get }
    
    var isEmpty: Bool { get }
    var Mode: MergeMode { get set }
    func merge(_ other: Self, _ mode: MergeMode) -> Self
    func canMergeWith(_ other: Self, _ condition: MergeCondition) -> Bool
    
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: IntegerLiteralType) -> Self
    static func /(lhs: Self, rhs: IntegerLiteralType) -> Self
    
    // view provision
    associatedtype AsViewType : View
    @ViewBuilder var asView: Self.AsViewType { get }
    
}

extension Mergable {
    func merge(_ other: Self, _ mode: MergeMode) -> Self {
        switch mode {
        case .add:         return self + other
        case .subtract:    return self - other
        case .half:        return self / 2
        case .double:      return self * 2
        case .replace:     return other
        case .clear:       return .empty
        }
    }   
}
extension Array where Element: Mergable {
    func getEmptyCount() -> Int {
        var result: Int = 0
        for i in 0..<count {
            if(self[i].isEmpty) {
                result += 1
            }
        }
        return result
    }
    
}
