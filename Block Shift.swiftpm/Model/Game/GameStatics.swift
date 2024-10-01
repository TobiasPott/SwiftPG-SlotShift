import SwiftUI

enum GameMode: CaseIterable {
    case none, num2048_5by5, num2048, colors
}

class GameStatics {
    static let colors: [Color] = [.pink, .red, .orange, /*.yellow,*/ /*.green,*/ .cyan, .blue, .purple]
    static let names: [GameMode:LocalizedStringKey] = [.none: "None", .num2048_5by5: "2048 (5 by 5)", .num2048: "2048 (Classic)", .colors: "Color (tbd)"]
    
    static private var _accentColor: Color = .clear
    static var accentColor: Color { get {
        if _accentColor == .clear {
            _accentColor = GameStatics.colors.randomElement()!
        }
        return _accentColor
    }}
    
    
    static let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(.sRGB, white: 0.2, opacity: 0.5), GameStatics.accentColor]), startPoint: .top, endPoint: .bottom)
    
    
    static func getName(_ mode: GameMode) -> LocalizedStringKey { return GameStatics.names[mode]! }
    
}
extension EdgeInsets {
    static let inset20 = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
}

extension View {
    
    // ToDo: PRIO 1: convert to container view which wraps a content closure with the required stack of modifiers and backgrounds
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
