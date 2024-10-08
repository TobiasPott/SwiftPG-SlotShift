import SwiftUI

struct SlotColor: Mergable, CustomStringConvertible {
    var red: Int;
    var green: Int;
    var blue: Int;
    var alpha: Int = 255;
    private var mergeMode: MergeMode
    
    var isEmpty: Bool { get { return red == Self.empty.red && blue == Self.empty.blue && green == Self.empty.green && alpha == Self.empty.alpha}}
    var Mode: MergeMode { get { return mergeMode } set { mergeMode = newValue } }
    
    init(red: Int, green: Int, blue: Int, alpha: Int = 255, mode: MergeMode) {
        self.red = red;
        self.green = green;
        self.blue = blue;
        self.alpha = alpha;
        self.mergeMode = mode;
    }
    var description: String { "\(red), \(green), \(blue), a: \(alpha) (\(self.Mode)" }
    
    
    func canMergeWith(_ other: Self, _ condition: MergeCondition) -> Bool {
        switch condition {
        case .match:       return self.red == other.red && self.green == other.green && self.blue == other.blue && (self.alpha != 0 || other.alpha != 0)
        default:           return false
        }
    }
    
    var asColor: Color {
        return Color(.sRGB, red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, opacity: 1.0)
    }
    var asView: some View {
        return ZStack {
            numberView
                .backgroundButton(self == .empty ? .gray.opacity(1.0) : asColor.opacity(1.0))
        }
        .aspectRatio(1.0, contentMode: .fit)
        .foregroundColor(asColor)
    }
    var numberView: some View {
        return VStack(spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
            }
        }
    }
}

// Static members
extension SlotColor {
    static let WEIGHTED: Picklist<Self> = Picklist([.init(.red, 10), .init(.green, 10), .init(.blue, 10), .init(.yellow, 10), .init(.purple, 10), .init(.cyan, 10)])    
    static let empty: Self = Self.init(red: 0, green: 0, blue: 0, alpha: 0, mode: .clear)
    
    static let white: Self = Self.init(red: 255, green: 255, blue: 255, mode: .clear)
    static let black: Self = Self.init(red: 0, green: 0, blue: 0, mode: .clear)
    
    static let red: Self = Self.init(red: 255, green: 0, blue: 0, mode: .clear)
    static let green: Self = Self.init(red: 0, green: 255, blue: 0, mode: .clear)
    static let blue: Self = Self.init(red: 0, green: 0, blue: 255, mode: .clear)
    static let yellow: Self = Self.init(red: 255, green: 255, blue: 0, mode: .clear)
    static let purple: Self = Self.init(red: 255, green: 0, blue: 255, mode: .clear)
    static let cyan: Self = Self.init(red: 0, green: 255, blue: 255, mode: .clear)
}

// Operator overloads
extension SlotColor {
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self.init(red: Int(UInt8(clamping:     Int(lhs.red) + Int(rhs.red))), 
                         green: Int(UInt8(clamping:   Int(lhs.green) + Int(rhs.green))), 
                         blue: Int(UInt8(clamping:    Int(lhs.blue) + Int(rhs.blue))), 
                         alpha: Int(UInt8(clamping:   Int(lhs.alpha) + Int(rhs.alpha))), 
                         mode: lhs.Mode)
    }
    static func - (lhs: Self, rhs: Self) -> Self {
        return Self.init(red: Int(UInt8(clamping:     Int(lhs.red) - Int(rhs.red))), 
                         green: Int(UInt8(clamping:   Int(lhs.green) - Int(rhs.green))), 
                         blue: Int(UInt8(clamping:    Int(lhs.blue) - Int(rhs.blue))), 
                         alpha: Int(UInt8(clamping:   Int(lhs.alpha) - Int(rhs.alpha))),
                         mode: lhs.Mode)
    }
    static func * (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red: Int(UInt8(clamping:     Int(lhs.red) * rhs)), 
                         green: Int(UInt8(clamping:   Int(lhs.green) * rhs)), 
                         blue: Int(UInt8(clamping:    Int(lhs.blue) * rhs)), 
                         alpha: Int(UInt8(clamping:   Int(lhs.alpha) * rhs)),
                         mode: lhs.Mode)
    }
    static func / (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red: Int(UInt8(clamping:     Int(lhs.red) / rhs)), 
                         green: Int(UInt8(clamping:   Int(lhs.green) / rhs)), 
                         blue: Int(UInt8(clamping:    Int(lhs.blue) / rhs)), 
                         alpha: Int(UInt8(clamping:   Int(lhs.alpha) / rhs)),
                         mode: lhs.Mode)
    }
}
