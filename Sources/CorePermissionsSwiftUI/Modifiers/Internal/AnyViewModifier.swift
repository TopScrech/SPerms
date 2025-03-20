import SwiftUI

@available(iOS 13, tvOS 13, *)
extension View {
    @usableFromInline func typeErased() -> AnyView {
        AnyView(self)
    }
}
