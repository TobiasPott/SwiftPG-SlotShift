import SwiftUI

struct PlayfieldSlotView<S: Mergable>: View {
    var entry: S;
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        //        if entry == .empty { 
        //            entry.asView.aspectRatio(1.0, contentMode: .fit)
        //        } 
        //        else {
        entry.asView
            .shadowDrop(radius: 2, x: 0, y: -1)
            .aspectRatio(1.0, contentMode: .fit)
            .scaleEffect(CGSize(width: scale, height: scale))
        //                .onAppear(perform: { withAnimation { scale = 1.0 } })
            .animation(.easeInOut(duration: 0.2).repeatCount(1, autoreverses: true), value: scale)
            .onChange(of: entry, perform: { value in
                if entry != .empty {
                    //                    scale = 0.0
                    //                    withAnimation { scale = 1.0 }
                    withAnimation { scale = 1.5 }
                    scale = 1.0
                }
            })
        //        }
    }
}
