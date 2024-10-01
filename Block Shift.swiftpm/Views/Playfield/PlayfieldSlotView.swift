import SwiftUI

struct PlayfieldSlotView<S: Mergable>: View {
    var entry: S;
    
    var body: some View {
        entry.asView
            .shadowDrop(.black, radius: 2, x: 0, y: -1)
            .aspectRatio(1.0, contentMode: .fit)
    }
}
