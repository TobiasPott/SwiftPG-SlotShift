import SwiftUI

struct TitleboardView: View {
    
    var body: some View {
        UIPanel {
            HStack(alignment: .top) {
                Image("title_logo").resizable().aspectRatio(1.0, contentMode: .fit)
                    .mask(RoundedRectangle(cornerRadius: 25))
                    .frame(maxHeight: 128.0)
                Text("2048-like game development & learning project").fontWeight(.light)
                    .frame(maxHeight: 128.0)
            }
        }        
    }
}
