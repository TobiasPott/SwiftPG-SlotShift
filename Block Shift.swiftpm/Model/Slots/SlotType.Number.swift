import SwiftUI

struct SlotNumber: Mergable {
    var red: Int;
    var alpha: Int = 255;
    private var mergeMode: MergeMode
    
    var isEmpty: Bool { get { return red == Self.empty.red && alpha == Self.empty.alpha}}
    var Mode: MergeMode { get { return mergeMode } set { mergeMode = newValue } }
    
    init(red: Int, alpha: Int = 255, mode: MergeMode) {
        self.red = red;
        self.alpha = alpha;
        self.mergeMode = mode;
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
        return Color(.sRGB, red: val, green: val, blue: val, opacity: Double(alpha) / 255.0)
    }
    var asView: some View {
        return ZStack {
            let isNotClear: Bool = Mode != .clear
            if isNotClear {
                numberView
                    .backgroundButtonNEW(GameStatics.accentColor)                
            } else {
                numberView
                    .backgroundButtonNEW(Color.gray)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
        .foregroundColor(asColor)
    }
    var numberView: some View {
        let isNotClear: Bool = Mode != .clear
        // getting the left padded string
        //        let valAsStr: String = red.toSlotText(withPad: "0")
        // getting the leading zero padding string
        //        let padAsStr: String = red.toSlotPaddingText(withPad: "0")
        
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
    static let empty: Self = Self.init(red: 0, alpha: 0, mode: .clear)
    
    static let one: Self = Self.init(red: 1, alpha: 255, mode: .clear)
    static let two: Self = Self.init(red: 2, alpha: 255, mode: .clear)
    static let four: Self = Self.init(red: 4, alpha: 255, mode: .clear)
    static let twofiftysix: Self = Self.init(red: 256, alpha: 255, mode: .clear)
    
    static let white: Self = Self.init(red: 255, alpha: 255, mode: .clear)
    static let black: Self = Self.init(red: 0, alpha: 255, mode: .clear)
    
    static let red: Self = Self.init(red: 255, alpha: 255, mode: .clear)
    static let green: Self = Self.init(red: 0, alpha: 255, mode: .clear)
    static let blue: Self = Self.init(red: 0, alpha: 255, mode: .clear)
    
    
    static let valueColors: [Color] = [.white, .red, .green, .blue, .red, .green, .blue]
}

// Operator overloads
extension SlotNumber {
    static func + (lhs: Self, rhs: Self) -> Self {
        return Self.init(red:     Int(lhs.red) + Int(rhs.red),  
                         alpha:   Int(lhs.alpha) + Int(rhs.alpha),
                         mode:    lhs.Mode)
    }
    static func - (lhs: Self, rhs: Self) -> Self {
        return Self.init(red:     Int(lhs.red) - Int(rhs.red),  
                         alpha:   Int(lhs.alpha) - Int(rhs.alpha),
                         mode:    lhs.Mode)
    }
    static func * (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red:     Int(lhs.red) * rhs,  
                         alpha:   Int(lhs.alpha) * rhs,
                         mode:    lhs.Mode)
    }
    static func / (lhs: Self, rhs: IntegerLiteralType) -> Self {
        return Self.init(red:     Int(lhs.red) / rhs,  
                         alpha:   Int(lhs.alpha) / rhs,
                         mode:    lhs.Mode)
    }
}


extension String {
    func paddingLeft(toLength: Int, withPad: any StringProtocol) -> String {
        var paddedStr = self
        
        while paddedStr.count < toLength {
            paddedStr = withPad + paddedStr
        }
        
        return paddedStr
    }
    func getCharacter(offset: Int) -> String {
        return "\(self[index(startIndex, offsetBy: offset)])"
    }
}

extension Int {
    func toSlotText(withPad: any StringProtocol) -> String {
        // use commented line to get hexadecimal string representation
        //        let baseString = String(format:"%02X", self)
        let baseString = String(format:"%D", self)
        return baseString.paddingLeft(toLength: 4, withPad: withPad)
    }
    func toSlotPaddingText(withPad: Character) -> String {
        // use commented line to get hexadecimal string representation
        //        let baseString = String(format:"%02X", self)
        let baseString = String(format:"%D", self)
        return String(repeating: withPad, count: 4 - baseString.count)
    }
}


