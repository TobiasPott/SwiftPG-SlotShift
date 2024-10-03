import SwiftUI


extension EdgeInsets {
    // extension to have fixed size insets to use with imported asset sprites and spacing
    static let inset20 = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
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

extension View {
    
    func backgroundPanel(_ color: Color = Statics.accentColor) -> some View {
        let buttonBG = Image("button_square_depth_line")
            .resizable(capInsets: .inset20)
        let inputBG = Image("input_outline_square")
            .resizable(capInsets: .inset20)
        
        let stack = Group {
            buttonBG.padding(.bottom, -8)
            inputBG
        }
        return self.background(stack.colorMultiply(color).shadowDrop(y: 4.0))
    }
    
    func backgroundButton(_ color: Color = Statics.accentColor) -> some View {
        let buttonBG = Image("button_square_depth_line").resizable(capInsets: .inset20)
        let inputBG = Image("button_square_line_thin").resizable(capInsets: .inset20)
        
        let stack = ZStack {
            
            Group {
                buttonBG
                inputBG
                    .padding(.bottom, 4)
            }.colorMultiply(color).shadowDrop(y: 2.5)
            self.padding(8)
                .padding(.bottom, 4)
        }.foregroundStyle(Color.primary)
        return stack
            .frame(minWidth: 32.0, minHeight: 32.0)
    }
}
