import SwiftUI

@available(iOS 13, tvOS 13, *)
struct AllowButtonSection: View {
    var action: () -> Void
    var useAltText: Bool
    
    @Binding var allowButtonStatus: AllowButtonStatus
    
    var buttonText: LocalizedStringKey {
        switch allowButtonStatus {
        case .allowed: "button_allowed"
        case .denied: "button_denied"
            
        case .idle:
            if useAltText {
                "button_next"
            } else {
                "button_allow"
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(buttonText, bundle: .module)
                .fontWeight(.bold)
                .buttonStatusColor(for: allowButtonStatus)
        }
        .layoutPriority(-1)
        .accessibility(identifier: "Allow button")
        .animation(.easeInOut, value: buttonText)
    }
}
