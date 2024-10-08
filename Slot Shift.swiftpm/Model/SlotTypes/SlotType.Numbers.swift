import SwiftUI

struct Slot2048: Mergable, CustomStringConvertible {
    var val: Int;
    var aux: Int = 255;
    var Mode: MergeMode

    var isEmpty: Bool { get { return val == Self.empty.val && aux == Self.empty.aux}}
    
    init(val: Int, aux: Int = 255, mode: MergeMode) {
        self.val = val;
        self.aux = aux;
        self.Mode = mode;
    }
    var description: String { "\(val), a: \(aux) (\(self.Mode)" }
    
    func canMergeWith(_ other: Self, _ condition: MergeCondition) -> Bool {
        switch condition {
        case .match:     return self.val == other.val && (self.aux != 0 || other.aux != 0)     
        default:         return false
        }
    }
    
    var asColor: Color {
        let chVal = Double(val) / 255.0
        return Color(.sRGB, red: chVal, green: chVal, blue: chVal, opacity: Double(aux) / 255.0)
    }
    var asView: some View {
        return ZStack {
            let isNotClear: Bool = Mode != .clear
            numberView
                .backgroundButton(isNotClear ? Statics.accentColor : Color.white.opacity(0.5))
        }
        .foregroundColor(asColor)
    }
    
    var numberView: some View {
        let isNotClear: Bool = Mode != .clear
        return VStack(spacing: 0) {
            if isNotClear {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    //                    Text(padAsStr).monospaced(size: 20.0)
                    //                    Text("\(red)").monospacedScaledToFit()
                    //                    Text(valAsStr).monospacedScaledToFit()
                    Text("\(val)").monospacedScaledToFit()
                }
            }
        }
        .frameInfinity(.bottomTrailing)
    }
    
}

// Static members
extension Slot2048 {
    static let WEIGHTED: Picklist<Self> = Picklist([.init(.one, 20), .init(.two, 30), .init(.four, 5)])
    static let empty: Self = Self.init(val: 0, aux: 0, mode: .clear)
    
    static let one: Self = Self.init(val: 1, aux: 255, mode: .clear)
    static let two: Self = Self.init(val: 2, aux: 255, mode: .clear)
    static let four: Self = Self.init(val: 4, aux: 255, mode: .clear)
    static let twofiftysix: Self = Self.init(val: 256, aux: 255, mode: .clear)
    
    static let white: Self = Self.init(val: 255, aux: 255, mode: .clear)
    static let black: Self = Self.init(val: 0, aux: 255, mode: .clear)
    
    static let red: Self = Self.init(val: 255, aux: 255, mode: .clear)
    static let green: Self = Self.init(val: 0, aux: 255, mode: .clear)
    static let blue: Self = Self.init(val: 0, aux: 255, mode: .clear)
    
    
    static let valueColors: [Color] = [.white, .red, .green, .blue, .red, .green, .blue]
}

// Operator overloads
extension Slot2048 {
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self.init(val:     Int(lhs.val) + Int(rhs.val),  
                         aux:     Int(lhs.aux) + Int(rhs.aux),
                         mode:    lhs.Mode)
    }
    static func - (lhs: Self, rhs: Self) -> Self {
        return Self.init(val:     Int(lhs.val) - Int(rhs.val),  
                         aux:     Int(lhs.aux) - Int(rhs.aux),
                         mode:    lhs.Mode)
    }
    static func * (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(val:     Int(lhs.val) * rhs,  
                         aux:     Int(lhs.aux) * rhs,
                         mode:    lhs.Mode)
    }
    static func / (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(val:     Int(lhs.val) / rhs,  
                         aux:     Int(lhs.aux) / rhs,
                         mode:    lhs.Mode)
    }
}
