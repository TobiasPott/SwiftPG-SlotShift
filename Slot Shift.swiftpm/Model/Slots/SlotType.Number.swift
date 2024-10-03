import SwiftUI

struct SlotNumber: Mergable {
    var red: Int;
    var aux: Int = 255;
    var Mode: MergeMode

    var isEmpty: Bool { get { return red == Self.empty.red && aux == Self.empty.aux}}
    
    init(red: Int, aux: Int = 255, mode: MergeMode) {
        self.red = red;
        self.aux = aux;
        self.Mode = mode;
    }
    
    func canMergeWith(_ other: Self, _ condition: MergeCondition) -> Bool {
        switch condition {
        case .match:     return self == other
        case .matchRGB:  return self.red == other.red    
        default:         return true
        }
    }
    
    var asColor: Color {
        let val = Double(red) / 255.0
        return Color(.sRGB, red: val, green: val, blue: val, opacity: Double(aux) / 255.0)
    }
    var asView: some View {
        return ZStack {
            let isNotClear: Bool = Mode != .clear
            numberView
                .backgroundButton(isNotClear ? Statics.accentColor : Color.white.opacity(0.5))
        }
        .aspectRatio(1.0, contentMode: .fit)
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
                    Text("\(red)").monospacedScaledToFit()
                }
            }
        }
        .frameInfinity(.bottomTrailing)
    }
    
}

// Static members
extension SlotNumber {
    static let WEIGHTED: Picklist<Self> = Picklist([.init(.one, 20), .init(.two, 30), .init(.four, 5)])
    static let empty: Self = Self.init(red: 0, aux: 0, mode: .clear)
    
    static let one: Self = Self.init(red: 1, aux: 255, mode: .clear)
    static let two: Self = Self.init(red: 2, aux: 255, mode: .clear)
    static let four: Self = Self.init(red: 4, aux: 255, mode: .clear)
    static let twofiftysix: Self = Self.init(red: 256, aux: 255, mode: .clear)
    
    static let white: Self = Self.init(red: 255, aux: 255, mode: .clear)
    static let black: Self = Self.init(red: 0, aux: 255, mode: .clear)
    
    static let red: Self = Self.init(red: 255, aux: 255, mode: .clear)
    static let green: Self = Self.init(red: 0, aux: 255, mode: .clear)
    static let blue: Self = Self.init(red: 0, aux: 255, mode: .clear)
    
    
    static let valueColors: [Color] = [.white, .red, .green, .blue, .red, .green, .blue]
}

// Operator overloads
extension SlotNumber {
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self.init(red:     Int(lhs.red) + Int(rhs.red),  
                         aux:     Int(lhs.aux) + Int(rhs.aux),
                         mode:    lhs.Mode)
    }
    static func - (lhs: Self, rhs: Self) -> Self {
        return Self.init(red:     Int(lhs.red) - Int(rhs.red),  
                         aux:     Int(lhs.aux) - Int(rhs.aux),
                         mode:    lhs.Mode)
    }
    static func * (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red:     Int(lhs.red) * rhs,  
                         aux:     Int(lhs.aux) * rhs,
                         mode:    lhs.Mode)
    }
    static func / (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red:     Int(lhs.red) / rhs,  
                         aux:     Int(lhs.aux) / rhs,
                         mode:    lhs.Mode)
    }
}
