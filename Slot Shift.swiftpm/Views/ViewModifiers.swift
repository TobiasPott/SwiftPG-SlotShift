import SwiftUI

extension View {
    func monospacedScaledToFit() -> some View {
        self.font(.system(size: 500, weight: .bold, design: .monospaced))
            .minimumScaleFactor(0.01)
    }
    func monospaced(size: CGFloat) -> some View {
        self.font(.system(size: size, weight: .bold, design: .monospaced))
    }
    
    func frameMax(_ width: CGFloat, _ height: CGFloat, _ alignment: Alignment = .center) -> some View { self.frame(maxWidth: width, maxHeight: height, alignment: alignment) }
    func frameInfinity(_ alignment: Alignment = .center) -> some View { self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment) }
    
    func squareFit() -> some View { self.aspectRatio(1.0, contentMode: .fit) }
    func squareFill() -> some View { self.aspectRatio(1.0, contentMode: .fill) }
    
    func roundedMask(_ cornerRadius: CGFloat = 20) -> some View { self.mask(RoundedRectangle(cornerRadius: cornerRadius)) }
    
    
    func shadowDrop(_ color: Color = .black.opacity(0.5), radius: CGFloat = 2.5, x: CGFloat = 0.0, y: CGFloat = 1.0) -> some View { self.shadow(color: color, radius: radius, x: x, y: y) }
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
}
