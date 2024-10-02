import SwiftUI

struct ButtonSquare: View {
    
    let action: () -> Void
    let systemName: String
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName).resizable()
                .squareFit()
        })
        
    }
}
