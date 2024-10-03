import SwiftUI


extension EdgeInsets {
    // extension to have fixed size insets to use with imported asset sprites and spacing
    static let inset20 = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
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
