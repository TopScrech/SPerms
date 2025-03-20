import SwiftUI

let screenSize = UIScreen.main.bounds

@available(iOS 13, tvOS 13, *)
struct Blur: UIViewRepresentable {
#if !os(tvOS)
    var style: UIBlurEffect.Style = .systemMaterial
#else
    var style: UIBlurEffect.Style = .regular
#endif
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
