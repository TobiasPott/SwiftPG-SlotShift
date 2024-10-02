import SwiftUI

extension EdgeInsets {
    static let inset20 = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
}


extension View {
    
    func backgroundPanel(_ color: Color = GameStatics.accentColor) -> some View {
        let buttonBG = Image("button_square_depth_line")
            .resizable(capInsets: .inset20)
        let inputBG = Image("input_outline_square")
            .resizable(capInsets: .inset20)
        
        let stack = ZStack {
            buttonBG.padding(.bottom, -8)
            inputBG
        }
        return self.background(stack.colorMultiply(color).shadowDrop(y: 4.0))
    }
    func backgroundButton(_ color: Color = GameStatics.accentColor) -> some View {
        let buttonBG = Image("button_square_depth_line")
            .resizable(capInsets: .inset20)
        let inputBG = Image("button_square_line_thin")
            .resizable(capInsets: .inset20)
        
        let stack = ZStack {
            buttonBG.padding(.bottom, -4)
            inputBG
        }.padding(20)
        return self.background(stack.colorMultiply(color).shadowDrop(y: 2.5)).foregroundStyle(Color.primary)
    }
    
    func backgroundButtonNEW(_ color: Color = GameStatics.accentColor) -> some View {
        let buttonBG = Image("button_square_depth_line").resizable(capInsets: .inset20)
        let inputBG = Image("button_square_line_thin").resizable(capInsets: .inset20)
        
        let stack = ZStack {
            
            Group {
                buttonBG
                inputBG
                    .padding(.bottom, 4)
            }.colorMultiply(color).shadowDrop(y: 2.5)
            self
            //                .background(.yellow.opacity(0.75))
                .padding(10)
                .padding(.bottom, 4)
            //                .background(.pink.opacity(0.7))
        }.foregroundStyle(Color.primary)
        return stack
            .frame(minWidth: 32.0, minHeight: 32.0)
    }
}
