import SwiftUI

struct PlayfieldView<S: Mergable>: View {
    
    @ObservedObject var matrix: Matrix<S>;
    var slotSpacing: CGFloat = 6.0
    
    var body: some View {
        
        VStack(spacing: slotSpacing) {
            ForEach(0 ..< matrix.size.rows, id: \.self) { row in
                PlayfieldColumnView(matrix: matrix, row: row, numOfColumns: matrix.size.columns, slotSpacing: slotSpacing)
            }
        }
    }
    
}




