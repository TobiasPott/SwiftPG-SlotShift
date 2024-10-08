import SwiftUI

struct AppAboutView: View {
    
    @State private var showHeader: Bool = false
    func hideAll() { showHeader = false;  }
    
    var body: some View {
        let maxWidth: CGFloat = 260.0
        let cornerAlignment: Alignment = .topLeading
        let cornerPaddingEdge: Edge.Set = [.top, .leading, .trailing, .bottom]
        let icon = Image(systemName: "info.circle").resizable().aspectRatio(1.0, contentMode: .fill)
        
        
        let str_b0_title: LocalizedStringKey = "About Slot Shift"
        let str_b0_p0: LocalizedStringKey = "Welcome to Slot Shift. \nA Swift game programming & learning project."
        let str_b0_p1: LocalizedStringKey = "Slot Shift is another app which I started development on to understand how it works and get a gist of how I would do it. Not it has reached a state I am comfortable with showing and sharing."
        let str_b0_p2: LocalizedStringKey = "You can check out the project's complete source code and asset files on github. You are free to make your own version and adopt the project as your own. I hope you can learn from it."
        
        let str_b1_title: LocalizedStringKey = "My Plea to You"
        let str_b1_p0: LocalizedStringKey = "I'm working for fun on this app and want to share it with the world. Thus I have no direct need to monitize this app."
        let str_b1_p1: LocalizedStringKey = "This said, you may find value in this app, I ask you to direct any appreciation towards people in need near you. \nThere are many out there who need help, be it some money to eat and drink or be it a short time of campanionship. Please take a moment and reconsider if you want to help someone in need."
        
        
        ZStack() {
            if showHeader {
                Button(action: { withAnimation { hideAll() } }, label: { Rectangle().foregroundStyle(.black).opacity(0.25) })
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            ///-> HEADER BLOCK
            VStack(alignment: cornerAlignment.horizontal) {
                Button(action: { withAnimation { showHeader.toggle() } }, label: { icon })
                    .backgroundButton().frameMax(48, 48)
                
                if showHeader {
                    UIPanel {
                        VStack(alignment: cornerAlignment.horizontal, spacing: 16.0) {
                            ScrollView {
                                Text(str_b0_title).font(Statics.titleFont).padding(Edge.Set.bottom, 6.0).padding(Edge.Set.top, 0.0)                   
                                VStack(alignment: HorizontalAlignment.leading) {
                                    Text(str_b0_p0).padding(Edge.Set.bottom, 3.0)
                                    Text(str_b0_p1).padding(Edge.Set.bottom, 3.0)
                                    Text(str_b0_p2).padding(Edge.Set.bottom, 3.0)
                                    Link(destination: URL(string: "https://github.com/TobiasPott/SwiftPG-SlotShift")!) {
                                        Text("GitHub Repository")
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                    }.foregroundStyle(.blue)
                                }
                                
                                Image(systemName: "heart.circle")
                                    .resizable()
                                    .frame(width: 32.0, height: 32.0).padding(Edge.Set.top)
                                Text(str_b1_title).font(Statics.titleFont)
                                    .padding(Edge.Set.bottom, 6.0)
                                VStack(alignment: HorizontalAlignment.leading) {
                                    Text(str_b1_p0).padding(Edge.Set.bottom, 3.0)
                                    Text(str_b1_p1).padding(Edge.Set.bottom, 3.0)
                                }
                                Spacer()
                                
                            }.padding()
                            
                        }.frame(maxWidth: maxWidth, alignment: cornerAlignment)
                    }.background(.brown.opacity(0.5))
                        .transition(.move(edge: .top))
                }
            }
            .padding(cornerPaddingEdge)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: cornerAlignment)
            
            
        }
    }
    
}
