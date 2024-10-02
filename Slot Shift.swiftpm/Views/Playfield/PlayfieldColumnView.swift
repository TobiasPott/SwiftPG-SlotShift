import SwiftUI

struct PlayfieldColumnView<S: Mergable>: View {
    @ObservedObject var matrix: Matrix<S>;
    let row: Int
    let numOfColumns: Int
    
    var slotSpacing: CGFloat = 6.0
    
    var body: some View {
        HStack(spacing: slotSpacing) {    
            ForEach(0 ..< numOfColumns, id: \.self) { column in 
                PlayfieldSlotView(entry: matrix[row, column])
                    .transition(.scale)
            }   
            
        }
    }
}
